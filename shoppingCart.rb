
require 'pry'
class ShoppingCart
	attr_reader :items
	def initialize(pricelist,season)
		@pricelist = pricelist
		@items = []
		@season = season
		@day = :sunday #should get day from Day, but for testing... 
	end

	def add_item_to_cart(item)
		@items << item
	end

	def show
		@items.each_with_index { |item,i| puts "#{i+1}\t#{item}\t$#{@pricelist[item][@season]}" }
	end

	def cost
		@items.reduce(0) {|sum,item| sum + @pricelist[item][@season] }
	end

	def apply_discount

		cart = {}
		disc_total = 0
		extra_bananas = 0
		@items.each do |i|

			cart[i] == nil ? cart[i] = 1 : cart[i]+= 1
		end


		cart.each do |key,qty|
			
			case key
			when :apple
	 			dQty = qty % 2 > 0 ? qty / 2+1 : qty / 2	 		
	 			disc_total += @pricelist[key][@season] * dQty	
			when :orange
				myMod = qty % 3 
				dQty = qty / 3 + myMod  
				disc_total += @pricelist[key][@season]  * dQty
	 		when :grapes
	 			extra_bananas = (qty / 4).round(0)
	 			disc_total += @pricelist[key][@season]  * qty
	 		when :banana
	 			disc_total += @pricelist[key][@season]  * qty
	 		when :watermelon
	 			watermelonCost = @pricelist[key][@season]  * qty
	 			@day == :sunday ?  watermelonCost *= 2 :
		 		disc_total += watermelonCost
		 		binding.pry
	 		end

		end

		if extra_bananas > 0
			(1..extra_bananas).each do
				add_item_to_cart(:banana)
			end
		end
		
		disc_total
		
	end

end

prices = { apple: {spring: 10, summer: 10, autumn: 15, winter: 12},
			orange: {spring: 5, summer: 2, autumn: 5, winter: 5},
			grapes: {spring: 15, summer: 15, autumn: 15, winter: 15},
			banana: {spring: 20, summer: 20, autumn: 20, winter: 21},
			watermelon: {spring: 50, summer: 50, autumn: 50, winter: 50}
		}


cart = ShoppingCart.new(prices,:winter)

cart.add_item_to_cart :apple
cart.add_item_to_cart :apple
cart.add_item_to_cart :apple
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :orange
cart.add_item_to_cart :orange
cart.add_item_to_cart :orange
cart.add_item_to_cart :watermelon


cart.show

puts "Total cost is: $#{cart.cost}"
puts "Discounted cost is: $#{cart.apply_discount}"