def find_item_by_name_in_collection(item, cart)
  cart.each do |thing|
    return thing if thing[:item] == item
  end
  nil
end

def consolidate_cart(cart)
  new_cart = []
  cart.each do |item|
    item_count = cart.count(item)
    new_cart.push(item.merge({count:item_count}))
  end
  new_cart.uniq
end

def apply_coupons(cart, coupons)

  cart.each do |item|

    coupons.each do |coupon|
      if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
        item[:count] -= coupon[:num]
        cart.push({item: "#{item[:item]} W/COUPON", price: coupon[:cost]/coupon[:num], clearance: item[:clearance], count: coupon[:num]})
      end
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  cart.each do |item|
    total += item[:count]*item[:price]
  end
  if total > 100
    total *= 0.9
  end
 total
end
