# frozen_string_literal: true

module Foundation
  module Storefront
    class OrdersController < BaseController
      before_action :require_signed_in, only: :index

      def index
        @orders = Order.where(user_id: current_user.id).order(created_at: :desc).to_a
      end

      def show
        @order = Order.includes(:line_items).find_by!(public_reference: params[:id])
        head :not_found unless ReceiptAccess.allowed?(order: @order, user: current_user, token: params[:access_token])
      end

      private

      def require_signed_in
        return if user_signed_in?

        redirect_to new_user_session_path, alert: "Sign in to see your past orders."
      end
    end
  end
end
