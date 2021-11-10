module States
  class ShowCards < BaseState
    def action
      puts I18n.t(:no_active_cards_message) if @situation.account.card.empty?

      @situation.account.card.each do |card|
        puts I18n.t(:row_card_message, card_number: card.number, card_type: card.type)
      end
    end
  end
end