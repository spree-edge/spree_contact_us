# frozen_string_literal: true

module Spree
  module Admin
    class InquiriesController < Spree::Admin::ResourceController
      before_action :find_inquiry, only: :destroy

      def index
        @search = Spree::Inquiry.ransack(params[:q])
        @collection = @search
                      .result
                      .order('spree_inquiries.created_at DESC')
                      .page params[:page]

        respond_with @collection
      end

      def destroy
        if @inquiry.destroy
          flash[:success] = "Inquiry deleted successfully"
          redirect_to admin_inquiries_path
        end
      end

      private

      def find_inquiry
        @inquiry = Spree::Inquiry.find(params[:id])
      end
    end
  end
end
