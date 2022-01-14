module Validation
  class Login < Validator
    def initialize(value)
      @value = value
      @errors = []
      super
    end

    def validate
      @errors.push(puts I18n.t(:login_validation)) if @value == ''
      @errors.push(puts I18n.t(:login_validation_length)) if @value.length < 4
      @errors.push(puts I18n.t(:login_validation_symbol)) if @value.length > 20
    end
  end
end
