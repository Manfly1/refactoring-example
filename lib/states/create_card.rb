module States
  class CreateCard < Base
    def action
      puts I18n.t(:create_card_message)
      @cards = Factories::CardFactory.card(read_input.to_sym)
      unless @cards
        puts I18n.t(:wrong_card_type_message)
        return
      end

      @context.state.extant_account.cards << @cards
      @context.state.save
    end

    def next
      return CreateCard.new(@context) unless @cards

      MenuAccount.new(@context)
    end
  end
end
