module Errors
  class TooSmallAmountError < StandardError
    def message
      puts(I18n.t(:too_small_amount_error))
    end
  end
end
