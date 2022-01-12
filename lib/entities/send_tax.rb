module Entities
  class SendTax < Tax
    def tax(amount)
      case @type
      when USUAL_TYPE then 20
      when CAPITALIST_TYPE then amount * 0.1
      when VIRTUAL_TYPE then 1
      else
        default_tax
      end
    end
  end
end
