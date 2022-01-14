module Validation
  class Age < Validator
    def validate
      @errors.push(puts(I18n.t(:age_validation))) unless @value.to_i.between?(23, 89)
    end
  end
end
