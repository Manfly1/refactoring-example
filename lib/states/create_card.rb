module States
  class CreateCard < BaseState
    def action
      puts I18n.t(:create_card_message)
      card = Entities::CardFactory.card(read_input.to_sym)
      if card == false
        puts I18n.t(:wrong_card_type_message)
        return @wrong_card = true
      end

      @situation.current_account.card << card
      @situation.save
    end

    def next
      return CreateCard.new(@situation) if @wrong_card

      MenuAccount.new(@situation)
    end
  end
end