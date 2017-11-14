require "pry"
class User 
    # This class is for the user 
    attr_accessor :name, :wallet, :cart

    def initialize(name, wallet, cart)
        @name = name
        @wallet = wallet
        @cart = cart
    end 
    
    def buy_item(store)
        puts "Which item would you like to buy please enter int"
        choice = gets.chomp.to_i
        if store.items[choice-1][:quantity] != 0 
            @cart.push({:name=> store.items[choice-1][:name], :price =>store.items[choice-1][:price]})
            #binding.pry
            if @wallet >=(store.items[choice-1][:price])
                @wallet -= (store.items[choice-1][:price])
                puts "item bought, you have $#{@wallet} left in your wallet"
                store.items[choice-1][:quantity] - 1
            else
                puts "Sorry you don't have enough money"
            end 
        else 
            puts "Sorry we don't have anymore of the items"
        end 
    end

    def money_left
        puts "You have $#{@wallet} left in your wallet"
    end 

    def add_money(amount)
        @wallet += amount
    end 

    def view_cart
        count = 1
        @cart.each do |x|
             puts "#{count}. #{x[:name]}"
             count += 1
        end

    end 

    def return_item(item, store)
        @wallet += @cart[item-1][:price]
        @cart.delete_at(item-1)


    end 


end