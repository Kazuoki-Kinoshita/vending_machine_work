class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  AVAILABLE_DRINKS = ["cola", "redbull", "water"].freeze

  attr_reader :sum, :sales_amount
  
  def initialize
    @sum = 0
    @sales_amount = 0 
    @drinks = [ {name: "cola", price: 120, stock: 5} ]
  end

  def add_new_drink(name, price, stock)
    new_drink = { name: name, price: price, stock: stock }
    if AVAILABLE_DRINKS.include?(new_drink[:name]) && !@drinks.any? { |d| d[:name] == new_drink[:name] }
      @drinks << new_drink
    end
  end

  def add_stock_drink(name, stock)
    if AVAILABLE_DRINKS.include?(name)
      @drinks.each { |d| d[:stock] += stock if d[:name] == name }
    end
  end

  def slot_money(money)
    if AVAILABLE_MONEY.include?(money)
      @sum += money 
    else
      puts "#{money}円は使えません"
    end
  end

  def return_money
    puts "#{@sum}円返却します"
    puts "残金は#{@sum = 0}円です"
  end

  def drink_information
    @drinks.each { |d| puts "#{d[:name]}は#{d[:price]}円で残りは#{d[:stock]}本です" }
  end

  def purchase(name)
    if select?(name)
      puts "#{name}を購入できます"
      @drinks.each do |drink|
        if drink[:name] == name
          drink[:stock] -= 1
          @sales_amount += drink[:price]
          @sum -= drink[:price]
          return_money
        end
      end
    end
  end

  def purchasable_drink 
    @drinks.map { |d| d[:name] if d[:price] <= @sum && d[:stock] >= 1 }
  end

  def select?(name)
    purchasable_drink.include?(name)
  end
end