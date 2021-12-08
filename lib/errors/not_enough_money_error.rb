module Errors
  class NotEnoughMoneyError < StandardError
    def message
      puts(I18n.t(:not_enough_money_error))
    end
  end
end
