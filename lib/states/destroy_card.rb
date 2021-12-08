module States
  class DestroyCard < Base
    MENU_STATE = :main_menu_message

    def next
      return MenuAccount.new(@context) if @next_state == MENU_STATE

      DestroyCard.new(@context)
    end

    def action
      return @next_state = MENU_STATE unless account_have_cards?(@context.extant_account.card)

      select_card
    end

    private

    def select_card
      print_cards(@context.extant_account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index, @context)

      apply_to_delete_cart(selected_card_index)
    end

    def apply_to_delete_cart(selected_card_index)
      puts I18n.t(:destroy_card_message, card_number: @context.extant_account.card[selected_card_index - 1].number)
      return unless read_input == APPLY_COMMAND

      delete_cart(selected_card_index)
      save_context
    end

    def delete_cart(selected_card_index)
      @context.extant_account.card.delete_at(selected_card_index - 1)
    end
  end
end
