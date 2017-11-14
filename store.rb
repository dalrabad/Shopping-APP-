class Store 
    attr_accessor :name, :items 

    def initialize(name, items)
        @name = name 
        @items = items
    end 

    def add_item(name, price, qauntatity)
        @items.push({:name => new_item, :price=> price, :quantity=> q})
    end 
end 