class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity, :cart, :product, :order

  belongs_to :cart
  belongs_to :product
  belongs_to :order

  def total_price
    quantity * product.price
  end
end
