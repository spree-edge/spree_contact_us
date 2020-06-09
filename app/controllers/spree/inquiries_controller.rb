# frozen_string_literal: true

module Spree
  class InquiriesController < Spree::StoreController
    def new
      @inquiry = Inquiry.new
    end

    def create
      @inquiry = Inquiry.new(inquiry_params.merge(extra_params))

      if validate_captcha && @inquiry.save
        InquiryMailer.notification(@inquiry).deliver # to submitter
        InquiryMailer.confirmation(@inquiry).deliver # to admin

        redirect_to contact_path, notice: Spree.t(:on_send_message)
      else
        render :new
      end
    end

    def index
      redirect_to(contact_path) unless params[:inquiry]
    end

    protected

    def extra_params
      {
        http_user_agent: request.env['HTTP_USER_AGENT'],
        http_remote_addr: request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
      }
    end

    def validate_captcha
      !has_invalid_captcha?
    end

    def has_invalid_captcha?
      if use_recaptcha?
        response = verify_recaptcha(recaptcha_params)

        # the recaptcha plugin inserts this flash message every time regardless of success/failure
        # spree_contact_us provides error + success notifications, it is safe to delete this
        flash.delete(:recaptcha_error)

        !response
      elsif Spree::ContactUsConfiguration[:use_honeypot]
        flash[:captcha_error] = Spree.t('honeypot.error_message') unless params[:honey].blank?
      end
    end

    def use_recaptcha?
      true
    end

    def recaptcha_params
      {
        model: @inquiry,
        message: Spree.t(:recaptcha_error_mes),
        private_key: Spree::ContactUsConfiguration[:recaptcha_private_key]
      }
    end

    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :phone_number, :inquiry_type, :order_no, :message)
    end
  end
end
