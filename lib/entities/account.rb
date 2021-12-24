module Entities
  class Account
    attr_reader :login, :name, :password, :age
    attr_accessor :cards

    def initialize(name:, login:, password:, age:)
      @name = name
      @login = login
      @password = password
      @age = age
      @cards = []
    end
  end
end
