module Validation
  class Login < Validator
    def initialize(value)
      @value = value
      @errors = []
      super
    end

    def validate
      @errors.push('Login must present') if @value == ''
      @errors.push('Login must be longer then 4 symbols') if @value.length < 4
      @errors.push('Login must be shorter then 20 symbols') if @value.length > 20
    end
  end
end
