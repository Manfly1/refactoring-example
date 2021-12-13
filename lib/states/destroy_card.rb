module States
  class DestroyCard < Base
    MENU_STATE = :main_menu_message

    def action
      return next_state unless check_if_have_cards

      choose_card
    end

    def next
      return MenuAccount.new(@context) if next_state

      DestroyCard.new(@context)
    end

    private

    def next_state
      @next_state = MENU_STATE
    end

    def check_if_have_cards
      account_have_cards?(@context.extant_account.card)
    end

    def choose_card
      print_cards(@context.extant_account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index)

      apply_to_delete_cart(selected_card_index)
    end

    def apply_to_delete_cart(selected_card_index)
      puts I18n.t(:destroy_card_message, card_number: @context.extant_account.card[selected_card_index - 1])
      return unless read_input == APPLY_COMMAND

      delete_cart(selected_card_index)
      save_context
    end

    def delete_cart(selected_card_index)
      @context.extant_account.card.delete_at(selected_card_index - 1)
    end
  end
end
