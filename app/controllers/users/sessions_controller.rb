class Users::SessionsController < Devise::SessionsController
  rescue_from ActionController::Redirecting::UnsafeRedirectError, with: :handle_unsafe_redirect

  before_action :check_store_membership, only: [:create]

  # def create
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password])
  #     if user.store == current_store
  #       # successful login for the current store
  #       # ...
  #     else
  #       # invalid login for a different store
  #       redirect_to login_path, alert: "You are not authorized to access this store. Please login with the correct credentials."
  #     end
  #   else
  #     # invalid email or password
  #     redirect_to login_path, alert: "Invalid email or password."
  #   end
  # end

  # DELETE /resource/sign_out
  def destroy
    # Get the user's storefront and its subdomain
    storefront = current_user.storefront
    subdomain = storefront.subdomain if storefront.present?
    
    # Sign out the user
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    
    # Redirect to the user's subdomain root page
    redirect_to after_sign_out_path_for(resource), allow_other_host: true if signed_out
  end

  private

  def handle_unsafe_redirect(exception)
    flash[:error] = "The URL you're trying to access is not safe because it's redirecting to a different host. Please check the URL and try again."
    redirect_back fallback_location: root_path
  end

  def check_store_membership
    user = User.find_by(email: params[:user][:email])
    if user && user.storefront && user.storefront != @current_storefront
      redirect_to new_user_session_path, alert: "Access denied. Please log in with valid credentials."
    end
  end

end
