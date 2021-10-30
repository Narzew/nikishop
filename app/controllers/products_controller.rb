class ProductsController < ApplicationController
    include ::KaminariApiMetaData

    before_action :set_product, only: %i[update destroy]

    def index
        products = Product.paged(page: params[:page], per_page: params[:per_page])
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

end
