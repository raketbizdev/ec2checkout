module ApplicationHelper
  def app_logo(image_name)
    image_path = Rails.root.join("app/assets/images/#{image_name}")
    url_for(image_path)
  end

  def app_name
    name = "ec2Checkout"
  end

  def user_subdomain
    current_user.storefront.subdomain if user_signed_in?
  end

  def current_subdomain
    current_subdomain = request.subdomain
  end
  def current_subdomain_url
    subdomain = current_subdomain.present? ? "#{current_subdomain}." : ""
    "#{request.protocol}#{subdomain}#{request.domain}:#{request.port}"
  end
  def current_user_subdomain_url
    subdomain = user_subdomain.present? ? "#{user_subdomain}." : ""
    "#{request.protocol}#{subdomain}#{request.domain}:#{request.port}"
  end
end
