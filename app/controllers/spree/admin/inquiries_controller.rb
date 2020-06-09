# frozen_string_literal: true

module Spree
  module Admin
    class InquiriesController < Spree::Admin::ResourceController
      def index
        @search = Spree::Inquiry.ransack(params[:q])
        @collection = @search
                      .result
                      .order('spree_inquiries.created_at DESC')
                      .page params[:page]

        respond_with @collection
      end
    end
  end
end
