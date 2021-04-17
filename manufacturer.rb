# frozen_string_literal: true

module Manufacturer
  def specify_manufacturer(name)
    self.manufacturer = name
  end

  def discover_manufacturer
    manufacturer
  end

  protected

  attr_accessor :manufacturer
end
