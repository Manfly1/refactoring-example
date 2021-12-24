module States
  class DestroyCard < Base
    def action
      return next_state unless account_have_cards?(account_card)

      choose_card
    end

    def next
      return MenuAccount.new(@context) unless account_have_cards?(account_card)

      DestroyCard.new(@context)
    end

    private

    def next_state
      @next_state = :main_menu_message
    end

    def account_card
      @context.state.extant_account.card
    end

    def choose_card
      print_cards(@context.state.extant_account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index)

      apply_to_delete_cart(selected_card_index)
    end

    def apply_to_delete_cart(selected_card_index)
      puts I18n.t(:destroy_card_message, card_number: @context.state.extant_account.card[selected_card_index - 1])
      return unless read_input == APPLY_COMMAND

      delete_cart(selected_card_index)
      save_context
    end

    def delete_cart(selected_card_index)
      @context.state.extant_account.card.delete_at(selected_card_index - 1)
    end
  end
end
