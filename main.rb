require_relative "User"
require_relative "Store"
require_relative "App"
require "pry"

#menu with options for the user to choose from
menu_options = ["1. Buy an item", "2. Return Item", "3. Request new items", "4. Show money left in wallet", "5. Add money to wallet", "6. View stores Inventory"]
app_name = "Shopping app"
stores = []
application = App.new(app_name, stores)
# First store. This Store is mainly for women 
store_name = "Women's Fashion"
# Items available at womens fashin store 
wf_items = [{:name => "Jean", :price => 20, :quantity => 10},
          {:name => "Sweater", :price => 30, :quantity => 50},
          {:name => "Scarfs", :price => 10, :quantity => 5},
          {:name => "Gloves", :price => 5, :quantity => 2},
          {:name => "Heels", :price => 60, :Quantity => 1}]
store_1 = Store.new(store_name, wf_items)
application.add_store(store_1)

# Creating store two
store_name = "Men's Fashion"
# Items available at men's fashin store 
mf_items = [{:name => "Tie", :price => 20, :Quantity=> 10},
            {:name => "Belts", :price => 30, :Quantity=> 50},
            {:name => "Button up", :price => 10, :Quantity=> 5},
            {:name => "T-shirt", :price => 5, :Quantity=> 2},
            {:name => "Dress Pants", :price => 60, :Quantity=> 1}]
store_2 = Store.new(store_name, mf_items)
application.add_store(store_2)


user_cart = [] #starts with an empty cart
user_name, user_money = application.prompt_user
# Create a new user 
user_1 = User.new(user_name, user_money, user_cart)

while true
    application.main_menu(menu_options)
    choice = gets.chomp
    if choice.to_i.is_a? String
        puts "Sorry we only accept numeric values"
        choice = gets.chomp.to_i
        until choice.is_a? Numeric
            puts "Please enter an integer number:"
            choice = gets.chomp.to_i
            break if choice.is_a? Numeric
        end
    end 
    case choice.to_i
    when 1
        application.stores.each {|x| puts "#{x.name}"}
        puts "please choose 1 for womens and 2 for mens "
        choice = gets.chomp.to_i
        while true 
            if choice == 1 # Women's Fashion 
                count = 1 
                application.stores[0].items.each do |x|
                    puts "#{count}. #{x[:name]} is $#{x[:price]}"
                    count +=1
                end 
                user_1.buy_item(stores[0])
                break
                
            elsif choice == 2 # Men's Fashion 
                count = 1 
                application.stores[1].items.each do |x|
                    puts "#{count}. #{x[:name]} is $#{x[:price]}"
                    count +=1
                end 
                user_1.buy_item(stores[0])
                break
            else 
                puts "Sorry store doesn't exist select again"
            end
            
        end 

    when 2 # Returning an item 
        # binding.pry
        if user_1.cart.size == 0 
            puts "You have nothing to return"
        else 
            puts "What item would you like to return?"
            user_1.view_cart
            return_choice = gets.chomp.to_i
            if return_choice > user_1.cart.size
                puts "Item doesn't exist"
            else
                puts "Which store are you returning to?"
                store_choice = gets.chomp.to_i
                item_name = user_1.cart[return_choice-1][:name]
                user_1.return_item(return_choice, store_choice)
                binding.pry
                #This here doesn't fully work 
                item_index = application.stores[store_choice-1].items.index { |x| x[:name] == item_name}
                binding.pry
                application.stores[store_choice-1].items[item_index][:quantity] += 1
            end 

        end 
    when 3 # Requesting a new item 
        puts "What item would you like to add?"
        new_item = gets.chomp
        puts "How much is the new item"
        new_price = gets.chomp.to_i
        puts "Which store would you like to add it to? 1 for Women's 2 for Men's"
        store_choice = gets.chomp.to_i

        if store_choice.to_i.is_a? String  # Check for correct input format 
            puts "Sorry we only accept numeric values"
            store_choice = gets.chomp.to_i
            until store_choice.is_a? Numeric
                puts "Please enter an integer number:"
                store_choice = gets.chomp.to_i
                break if store_choice.is_a? Numeric
            end
        end 

        if store_choice == 1 # Women's Fashion
            store_1.items.push({:name => new_item, :price => new_price, :quantity => 1})
        elsif store_choice == 2 # Men's Fashion 
            store_2.items.push({:name => new_item, :price => new_price, :quantity => 1})
        else
            puts "Sorry store doesn't exist"
        end 

    when 4 # Show money left in wallet 
        user_1.money_left
    when 5 # Add money to the wallet
        puts "How much would you like to add?"
        amount = gets.chomp.to_i
        user_1.add_money(amount)
    when 6
        application.stores.each do |x|
            puts "The #{x.name} store has"
            x.items.each {|x| puts "#{x[:name]}"}
        end 
    else 
        exit 
    end 
end

