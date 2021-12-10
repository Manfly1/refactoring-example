module Modules
  module Validates
    def balance_valid?(balance)
      return true unless balance.negative?

      puts I18n.t('no_money')
    end

    def amount_valid?(amount)
      return true if amount.positive?

      puts I18n.t('wrong_money_amount')
    end

    def card_index_valid?(selected_card_index, _context)
      return true if selected_card_index

      puts I18n.t('choose_correct_card')
    end

    def account_have_cards?(cards)
      return true if cards.any?

      puts I18n.t('no_active_cards_message')
    end
  end
end
