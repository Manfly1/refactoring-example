module Validates
  def balance_valid?(balance)
    puts I18n.t('no_money') unless balance.negative?
  end

  def amount_valid?(amount)
    puts I18n.t('wrong_money_amount') if amount.positive?
  end

  def card_index_valid?(selected_card_index)
    puts I18n.t('choose_correct_card') if selected_card_index
  end

  def account_have_cards?(cards)
    puts I18n.t('no_active_cards_message') unless cards.any?
  end
end
