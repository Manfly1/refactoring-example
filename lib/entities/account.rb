module Entities
  class Account
    attr_accessor :cards
    attr_reader :login, :password, :name, :age

    def initialize(login:, password:, name:, age:)
      @login = login
      @password = password
      @name = name
      @age = age
      @cards = []
    end
  end
end
