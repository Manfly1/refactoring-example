module Validation
  class Password < Validator
    def validate
      @errors.push(puts(I18n.t(:password_validation))) if @value.empty?
      @errors.push(puts(I18n.t(:password_validation_longer))) if @value.length < 6
      @errors.push(puts(I18n.t(:password_validation_shorter))) if @value.length > 30
    end
  end
end
