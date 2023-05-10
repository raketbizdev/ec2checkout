
class Storefronts::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_storefront
  before_action :set_product, only: [:edit, :destroy]

  def index
    @products = @storefront.products.page(params[:page]).per(12)
  end

  def edit
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def set_storefront
    @storefront = Storefront.find_by(subdomain: request.subdomain)
  end

  def set_product
    @product = @storefront.products.find(params[:id])
  end
end