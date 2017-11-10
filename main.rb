require "user"
require "store"
require "app"

app_name = "Shopping app"
App.new(app_name)

user_name, user_money = app.prompt_user
user_cart = [] #starts with an empty cart

# Create a new user 
user_1 = User.new(user_name, user_money, user_cart)

