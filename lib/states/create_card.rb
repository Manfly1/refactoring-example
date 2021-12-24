module States
  class CreateCard < Base
    def action
      puts I18n.t(:create_card_message)
      @card = Factories::CardFactory.card(read_input.to_sym)
      unless @card
        puts I18n.t(:wrong_card_type_message)
        return
      end

      @context.state.extant_account.card << @card
      @context.state.save
    end

    def next
      return CreateCard.new(@context) unless @card

      MenuAccount.new(@context)
    end
  end
end
