class StorefrontsController < ApplicationController
  before_action :require_subdomain
  before_action :authenticate_user!, only: [:index, :signout]
  def index
    @storefront = Storefront.find_by_subdomain(request.subdomain)
    @products = @storefront.products.page(params[:page]).per(12)
  end


  def show
    @storefront = Storefront.includes(:products).find_by(subdomain: request.subdomain)

    if @storefront.present?
      @products = @storefront.products.page(params[:page]).per(12)
      # other code for rendering the storefront
    else
      # Redirect to the root path if the storefront is not found
      redirect_to root_path, alert: 'Storefront not found.'
    end
  end
  def signin
    redirect_to new_user_session_url(subdomain: request.subdomain)
  end
  def signout
    redirect_to destroy_user_session_url(subdomain: request.subdomain)
  end

  private

  def find_storefront
    @storefront = Storefront.find_by(subdomain: request.subdomain)
    render_not_found if @storefront.nil?
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end