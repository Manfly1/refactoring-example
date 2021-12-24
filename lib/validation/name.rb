module Validation
  class Name < Validator
    def validate
      return if @value != '' && @value[0].upcase == @value[0]

      @errors.push('Your name must not be empty and starts with first upcase letter')
    end
  end
end
