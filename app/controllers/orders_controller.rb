class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_order, only: [:show]


   def create
        ActiveRecord::Base.transaction do
            amount = calculate_total(params[:items])

            @order = current_user.orders.create!(amount: amount)

            params[:items].each do |item_id, quantity|
                OrdersDescription.create!(
                    order: @order,
                    item_id: item_id,
                    quantity: quantity
                )
            end

        render json: @order, status: :created
        end
    rescue ActiveRecord::RecordInvalid => e
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def index
        @orders = current_user.orders.includes(:orders_descriptions, :items)
        render json: @orders, include: { orders_descriptions: {include: :item} }
    end

    def show
        render json: @order, include: { orders_descriptions: {include: :item} }
    end


    private

    def calculate_total(items)
        items = items.to_unsafe_h if items.respond_to?(:to_unsafe_h)
        item_prices = Item.where(id: items.keys).pluck(:id, :price).to_h
        items.sum do |item_id, quantity|
          price = item_prices[item_id.to_i]
          price * quantity.to_i if price
        end
    end
end
