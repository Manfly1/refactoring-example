module Entities
  class WithdrawTax < Tax
    def tax(amount)
      return amount * TAXES[@type] if TAXES.key?(@type)

      default_tax
    end
  end
end
