module Validation
  class Name < Validator
    def validate
      return if @value.empty? && @value[0].upcase == @value[0]

      @errors.push(puts(I18n.t(:name_validation)))
    end
  end
end
