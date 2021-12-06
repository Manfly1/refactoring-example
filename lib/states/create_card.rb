module States
  class CreateCard < BaseState
    def step
      return CreateCard.new(@context) if @wrong_card

      MenuAccount.new(@context)
    end
  end

  def action
    puts I18n.t(:create_card_message)
    card = Entities::CardFactory.card(read_input.to_sym)
    if card == false
      puts I18n.t(:wrong_card_type_message)
      return @wrong_card = true
    end
    @context.extant_account.card << card
    @context.save
  end
end
