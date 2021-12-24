module Validate
  def balance_valid?(balance)
    balance.negative?
  end

  def amount_valid?(amount)
    amount.positive?
  end

  def card_index_valid?(selected_card_index)
    selected_card_index.positive?
  end

  def account_have_cards?(cards)
    cards.any?
  end
end
