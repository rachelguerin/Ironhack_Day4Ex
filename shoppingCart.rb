

class ShoppingCart
	attr_reader :items
	def initialize
		@items = []
	end

	def add_item_to_cart(item)
		@items << item
	end

	def show
		@items.each_with_index { |item,i| puts "#{i+1} #{item[:name]} #{item[:cost]}$" }
	end

	def cost
		@items.reduce(0) {|sum,item| sum + item[:cost] }
	end

end

apple = {	name: "apple", cost: 10 }
oranges = { name: "orange", cost: 5 }
grapes = { name: "grapes", cost: 15 }
banana = { name: "banana", cost: 20 }
watermelon = { name: "watermelon", cost: 50 }

cart = ShoppingCart.new

cart.add_item_to_cart apple
cart.add_item_to_cart banana
cart.add_item_to_cart banana

cart.show

puts "Total cost is: #{cart.cost}$"