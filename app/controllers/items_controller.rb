class ItemsController < ApplicationController
  before_action :authenticate_user! 
  before_action :authorize_admin!, only: [:update] 
  before_action :set_item, only: [:update]

  def index
    @items = Item.all

    if params[:name].present?
      @items = @items.where("name ILIKE ?", "%#{params[:name]}%")
    end
  
    @items = @items.page(params[:page]).per(params[:per_page] || 10) # Пагинация
  
    render json: {
      items: @items,
      meta: {
        current_page: @items.current_page,
        total_pages: @items.total_pages,
        total_count: @items.total_count
      }
    }
  end

  def update
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_admin!
    unless current_user&.admin?
      render json: { error: "Access denied" }, status: :forbidden
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
