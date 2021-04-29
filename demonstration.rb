# frozen_string_literal: true

class Demonstration
  def demonstrate
    # attr_accessor_with_history
    Station.attr_accessor_with_history :a, :b
    s = Station.new('A')
    s.a = 5
    s.a = 6
    puts(s.a) # 6
    puts(s.a_history.inspect) # [5, 6]
    puts(s.b.inspect) # nil
    puts(s.b_history.inspect) # []
    s2 = Station.new('B')
    puts(s2.a_history.inspect) # []

    # strong_attr_accessor
    Station.strong_attr_accessor :c, String
    s.c = 'abc'
    puts(s.c) # abc
    # s.c = 3 #error : Attribute must be of type String

    # Validation module
    Train.new('abc-23', 'грузовой') # ок
    # Train.new('', 'грузовой') # RuntimeError (@number can't be empty)
    # Train.new('abc-23', nil) # RuntimeError (@type can't be nil)
    # Train.new(1, 'грузовой') # RuntimeError (@number must be of type String)
    # Train.new('abc-2334', 'грузовой') # RuntimeError (Invalid format for @number)
    # Train.new('abc-23', 'груз') # RuntimeError (Invalid format for @type)
  end
end
