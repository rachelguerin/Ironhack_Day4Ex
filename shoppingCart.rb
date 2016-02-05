require 'colorize'

class ShoppingCart
	attr_reader :items
	def initialize(pricelist)
		@pricelist = pricelist
		@items = []	
		@today = Time.now
		@discount_total = 0
		@season = set_season(@today)
	end

	def set_season(day)
		s = day.yday / 91
		case s
		when 0
			@season = :winter
		when 1
			@season = :spring
		when 2
			@season = :summer
		else
			@season = :autumn
		end
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
				puts "Apples: Buy 2 pay for 1!"
	 			accumulate_discount_total(@pricelist[key][@season],get_disc_qty(qty,2)) 			
			when :orange 
				puts "Oranges: Buy 3 pay just for 2!"
				accumulate_discount_total(@pricelist[key][@season],get_disc_qty(qty,3))
	 		when :grapes
	 			puts "Grapes: Buy 4 get a free banana!"
	 			extra_bananas = (qty / 4).round(0)
	 			accumulate_discount_total(@pricelist[key][@season],qty)
	 		when :banana
	 			accumulate_discount_total(@pricelist[key][@season],qty)
	 		when :watermelon
	 			puts "Watermelon: Half price weekdays & Saturday!"
	 			watermelonCost = @pricelist[key][@season]  
	 			@today.sunday? ?  watermelonCost : watermelonCost/2
		 		accumulate_discount_total(watermelonCost,qty)
	 		end

		end

		if extra_bananas > 0
			(1..extra_bananas).each do
				add_item_to_cart(:banana)
			end
		end
		
		@discount_total
		
	end

	def get_disc_qty(qty,num)
		rem = qty % num
		dQty = qty / num + rem
	end
	
	def accumulate_discount_total(price,qty)

		@discount_total += price * qty
	end
end

prices = { apple: {spring: 10, summer: 10, autumn: 15, winter: 12},
			orange: {spring: 5, summer: 2, autumn: 5, winter: 5},
			grapes: {spring: 15, summer: 15, autumn: 15, winter: 15},
			banana: {spring: 20, summer: 20, autumn: 20, winter: 21},
			watermelon: {spring: 100, summer: 100, autumn: 100, winter: 100}
		}


cart = ShoppingCart.new(prices)

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

puts "Total cost is: $#{cart.cost}".colorize(:red)
puts "Discounted cost is: $#{cart.apply_discount}".colorize(:green)