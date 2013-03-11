class ApplicationController < ActionController::Base

#  before_filter :authorize_normal
  before_filter :authorize
  protect_from_forgery
  
  def user_is_logged_in?
    !!session[:user_id]
  end



  private

  # Searches for the cart based on cart_id; if id doesn't exist
  # a new cart is created.
  def current_cart
  	Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
  	cart = Cart.create
  	session[:cart_id] = cart.id
  	cart
  end

  protected


    def authorize   
      user = User.find_by_id(session[:user_id]) 
      unless user
        unless user != nil and user.is_admin?
          redirect_to login_url, :notice => "Please log in"
        end
      end
    end
end
