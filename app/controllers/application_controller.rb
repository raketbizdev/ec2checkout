class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_mailer_host
  helper_method :require_subdomain
  before_action :set_current_storefront

  def set_current_storefront
    @current_storefront ||= Storefront.find_by(subdomain: request.subdomain)
  end
  private
    def require_subdomain
      if request.subdomain.blank? || request.subdomain == 'www'
        # Handle the case when there is no subdomain or 'www'
        # Example: redirect to a specific subdomain
        # redirect_to root_url(subdomain: 'example') and return false
        # Example: render a specific view
        render 'statics/index' and return false
      elsif subdomain_exist?
        true
      else
        render template: 'errors/show', status: :not_found and return false
      end
    end  

    def subdomain_exist?
      subdomain = request.subdomain.presence || 'www'
      return true if subdomain == 'www' # Allow www subdomain to pass through
      storefront = Storefront.find_by(subdomain: subdomain)
      
      if storefront.present?
        true
      else
        false
      end
    end

    def set_mailer_host
      if Rails.env.production?
        Rails.application.routes.default_url_options[:host] = 'www.ec2checkout.com'
      else
        subdomain = request.subdomain.present? ? "#{request.subdomain}." : ""
        Rails.application.routes.default_url_options[:host] = "#{subdomain}lvh.me:3000"
      end
    end
  protected

    def after_sign_in_path_for(resource)
      subdomain = resource.storefront.subdomain
      # Set the user_subdomain in session
      session[:user_subdomain] = subdomain

      # Redirect to the user's subdomain products page
      storefronts_products_url(subdomain: subdomain)
    end

    def after_sign_out_path_for(resource)
      subdomain = session[:user_subdomain]
      session.delete(:user_subdomain)
      # Redirect to the user's subdomain root page
      # url_for(controller: 'storefronts', action: 'show', subdomain: subdomain, only_path: false)
      storefronts_products_url(subdomain: subdomain)
    end
end