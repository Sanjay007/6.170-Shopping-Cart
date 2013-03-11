class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :paytype
  PAYMENT_TYPES = ["Check", "Credit Card"]
  has_many :line_items, :dependent => :destroy
  belongs_to :customer
  validates :name, :address, :email, :presence => true

  def add_items (cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end


end