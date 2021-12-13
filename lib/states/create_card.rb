module States
  class CreateCard < Base
    def action
      puts I18n.t(:create_card_message)
      @card = Factories::CardFactory.card(read_input.to_sym)
      unless @card
        puts I18n.t(:wrong_card_type_message)
        return @wrong_card = true
      end

      @context.extant_account.card << @card
      @context.save
    end

    def next
      return CreateCard.new(@context) if @wrong_card

      MenuAccount.new(@context)
    end
  end
end
