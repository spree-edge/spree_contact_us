# frozen_string_literal: true

module Spree
  class InquiriesController < Spree::StoreController
    before_action :reload_recaptcha_preferences, only: :new

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

    def validate_captcha
      captcha_valid = true
      honeypot_valid = true

      captcha_valid = handle_captcha_validation unless Spree::ContactUsConfiguration[:use_captcha] == false

      honeypot_valid = handle_honeypot_validation unless Spree::ContactUsConfiguration[:use_honeypot] == false

      captcha_valid && honeypot_valid
    end

    def handle_captcha_validation
      response = verify_recaptcha(recaptcha_params)
      unless response
        flash[:captcha_error] = Spree.t('recaptcha_error_mes')
        return false
      end
      true
    end

    def handle_honeypot_validation
      if params[:honey].present?
        flash[:captcha_error] = Spree.t('honeypot.error_message')
        return false
      end
      true
    end

    def reload_recaptcha_preferences
      site_key = Spree::ContactUsConfiguration[:recaptcha_public_key]
      secret_key = Spree::ContactUsConfiguration[:recaptcha_private_key]

      if site_key.present? && secret_key.present?
        Recaptcha.configure do |config|
          config.site_key = site_key
          config.secret_key = secret_key
        end
      end
    end
  end
end
