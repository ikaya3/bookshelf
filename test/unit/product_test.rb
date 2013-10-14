require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attribute must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "hoge",
                          description: "YYY",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than 0",
    product.errors[:price].join("; ")

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than 0",
    product.errors[:price].join("; ")

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "hogehoge",
                description: "fugafuga",
                price: 23.45,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.jpg
             http://x.y.z/a/b/c/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?
    end

    bad.each do |name|
      assert new_product(name).invalid?
    end
  end

  test "use fixture" do
    assert products(:one).valid?
    assert products(:two).invalid?
  end
end
