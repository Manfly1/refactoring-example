module States
  class CreateCard < Base
    def action
      @cards = Factories::CardFactory.card(read_input_with_title(I18n.t(:create_card_message)).to_sym)
      unless @cards
        I18n.t(:wrong_card_type_message)
        return
      end

      @context.extant_account.cards << @cards
      @context.save
    end

    def next
      return CreateCard.new(@context) unless @cards

      MenuAccount.new(@context)
    end
  end
end
