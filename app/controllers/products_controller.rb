# frozen_string_literal: true

class ProductsController < ApplicationController
  include ::KaminariApiMetaData

  before_action :set_product, only: %i[update destroy]
  before_action :initialize_session

  def index
    # Filter products
    products = Product
    # Filter by category
    products = products.filter_category(params[:category_id]) if params[:category_id].present?

    # Filter by price
    if params[:price].present?
      products = if params[:price].include?('<=')
                   products.filter_price_lower_equal(params[:price].gsub('<=', '').to_i)
                 elsif params[:price].include?('>=')
                   products.filter_price_greater_equal(params[:price].gsub('>=', '').to_i)
                 elsif params[:price].include?('<')
                   products.filter_price_lower(params[:price].gsub('<', '').to_i)
                 elsif params[:price].include?('>')
                   products.filteR_price_greater(params[:price].gsub('>', '').to_i)
                 else
                   products.filter_price_exact(params[:price].to_i)
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

  # Add item to cart
  def add_to_cart
    product_id = params[:id].to_i
    session[:cart] << product_id
    render json: {
      status: 'Item added to cart'
    }, status: 200
  end

  # Delete item from cart
  def remove_from_cart
    item_id = params[:id].to_i
    if session[:cart].include?(item_id)
      # Delete only one occurence of item in cart
      session[:cart].delete_at(session[:cart].index(item_id))
      render json: {
        status: 'Item deleted from cart'
      }, status: 200
    else
      render json: {
        status: "Item wasn't in cart"
      }, status: 202
    end
  end

  # Show cart
  def show_cart
    @products = Product.where(id: session[:cart].uniq)
    @sum = 0
    @result_array = session[:cart].tally.map do |product_id, quantity|
      current_product = @products.find(product_id)
      @sum += current_product['price'] * quantity
      {
        name: current_product['name'],
        price: current_product['price'],
        quantity: quantity,
        total: current_product['price'] * quantity
      }
    end
    render json: {
      status: 'OK',
      sum: @sum,
      cart: @result_array.as_json
    }, status: 200
  end

  def finalize_transaction
    session[:cart] = []
    render json: {
      status: 'OK'
    }, status: 200
  end

  private

  def initialize_session
    # Initialize new cart if it was previously empty
    session[:cart] ||= []
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :category, :page, :per_page
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
