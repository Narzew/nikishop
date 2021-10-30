# frozen_string_literal: true

class ProductsController < ApplicationController
  include ::KaminariApiMetaData

  before_action :set_product, only: %i[update destroy]

  def index
    # Filter products
    products = Product
    # Filter by category
    products = products.filter_category(params[:category_id]) if params[:category_id].present?

    # Filter by price
    if params[:price].present?
        if params[:price].include?("<=")
            products = products.filter_price_lower_equal(params[:price].gsub("<=","").to_i)
        elsif params[:price].include?(">=")
            products = products.filter_price_greater_equal(params[:price].gsub(">=","").to_i)
        elsif params[:price].include?("<")
            products = products.filter_price_lower(params[:price].gsub("<","").to_i)
        elsif params[:price].include?(">")
            products = products.filteR_price_greater(params[:price].gsub(">","").to_i)
        else
            products = products.filter_price_exact(params[:price].to_i)
        end
    end

    # Page products
    products = products.paged(page: params[:page], per_page: params[:per_page])
    render json: {
      data: ActiveModel::SerializableResource.new(products, each_serialize: ProductSerializer),
      meta: meta_data(products)
    }
  end

  def show
    product = Product.find(params[:id])
    render json: ProductSerializer.new(product).to_h
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Search by name
  def search
    if params[:name].present?
      products = Product.search(params[:name]).paged(page: params[:page], per_page: params[:per_page])
      render json: {
        data: ActiveModel::SerializableResource.new(products, each_serialize: ProductSerializer),
        meta: meta_data(products)
      }
    else
      render json: {}
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :category, :page, :per_page
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
