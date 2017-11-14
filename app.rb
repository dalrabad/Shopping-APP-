require_relative "Store"
class App 
    # This class is for the user 
    attr_accessor :name, :stores

    def initialize(name, store)
        @name = name
        @stores = store 
    end 

    def prompt_user
        puts "What is your name"
        user_name= gets.chomp
        puts "How much money do you have?"
        user_money= gets.chomp.to_i
        return user_name, user_money
    end

    def main_menu(menu_options)
        puts" What would you like to do?"
        menu_options.each {|x| puts"#{x}"}
    end

    def add_store(store_to_Add)
        @stores.push(store_to_Add)
    end

end