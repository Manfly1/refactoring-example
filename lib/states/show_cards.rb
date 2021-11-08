module States
  class ShowCards < BaseState
    def action
      puts I18n.t(no_active_cards_message:) if @situation.current_account.card.empty?

      @situation.current_account.card.each do |card|
        puts I18n.t('card_row', card_number: card.number, card_type: card.type)
      end
    end
  end
end