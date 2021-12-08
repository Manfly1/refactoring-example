module States
  class PutMoney < Base
    def next
      MenuAccount.new(@context)
    end

    def action
      puts I18n.t(:put_money_message)
      return unless account_have_cards?(@context.extant_account.card)

      select_card_step
    end

    private

    def read_amount_step(selected_card_index, extant_card)
      input_amount = read_input_with_title(I18n.t(:put_amount_message)).to_i
      return unless amount_valid?(input_amount)

      read_tax_step(selected_card_index, extant_card, input_amount)
    end

    def select_card_step
      print_cards(@context.extant_account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index, @context)

      selected_card_index -= 1
      extant_card = @context.extant_account.card[selected_card_index]
      read_amount_step(selected_card_index, extant_card)
    end

    def read_tax_step(selected_card_index, extant_card, input_amount)
      tax = put_tax(extant_card.type, input_amount)
      return unless tax_valid?(tax, input_amount)

      extant_card.balance = extant_card.balance + input_amount - tax
      @context.extant_account.card[selected_card_index] = extant_card
      @context.save
      put_stats(input_amount, extant_card.number, extant_card.balance, tax)
    end

    def tax_valid?(tax, amount)
      return true if tax < amount

      puts I18n.t(:invalid_amount_message)
      false
    end
  end
end
