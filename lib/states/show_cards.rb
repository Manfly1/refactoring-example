module States
  class ShowCards < Base
    def action
      puts I18n.t(:no_active_cards_message) if cards.empty?
      cards.each do |card|
        puts I18n.t(:row_card_message, card_number: card.number, card_type: card.type)
      end

      def next
        MenuAccount.new(@context)
      end
    end
  end
end
