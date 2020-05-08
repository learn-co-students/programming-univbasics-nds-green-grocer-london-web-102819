require "pry"
def find_item_by_name_in_collection(name, collection)
  collection.find do |item|
    item.has_value?(name) 
  end
  
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  result = [ ]
  i = 0
  while i<cart.size do
    grocery = find_item_by_name_in_collection(cart[i][:item], result)
      if grocery != nil 
        grocery[:count]+= 1
      elsif grocery == nil 
        result << cart[i]
        cart[i][:count]=1
      end
    i +=1
  end
  result 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  i= 0
  while i < cart.size do
    coupon =find_item_by_name_in_collection(cart[i][:item], coupons)
      # if item[i][:count] < coupon[:num]
      #   #coupon's not valid
      if coupon != nil
        if cart[i][:count] >= coupon[:num]
          remaining_count = cart[i][:count] - coupon[:num]
          new_price_w_coupon=coupon[:cost]/coupon[:num]
          remaining_item = cart[i].clone
          remaining_item[:count] = remaining_count
          cart[i][:item] ="#{cart[i][:item]} W/COUPON"
          cart[i][:price] = new_price_w_coupon
          cart[i][:count] = coupon[:num]
          cart<<remaining_item
        
        end
      end
  i+=1
  end
cart
end
  # binding.pry   

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

def apply_clearance(cart)
  i = 0
  while i < cart.size do
    if cart[i][:clearance] == true
      cart[i][:price] =( cart[i][:price]*0.8).round(2)
    end 
    i+=1  
  end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart 
end

def checkout(cart, coupons)
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  # binding.pry
  total=0
  i=0
  while i<cart.size do
    total += cart[i][:price] * cart[i][:count]
    i+=1
  end
  if total > 100
    total = total*0.9
  end
  total 
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
