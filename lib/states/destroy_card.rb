module States
  class DestroyCard < BaseState

    def action
      return @next_state = 'main_menu_message' unless account_have_cards?(@situation.current_account.card)

      select_card
    end

    def next
      return MenuAccount.new(@situation) if @next_state == 'main_menu_message'

      DestroyCard.new(@situation)
    end

    def select_card
      print_cards(@situation.current_account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index, @situation)

      agree_to_delete_cart(selected_card_index)
    end

    def agree_to_delete_cart(selected_card_index)
      puts I18n.t(:destroy_card_message, card_number: @situation.current_account.card[selected_card_index - 1].number)
      return unless read_input == APPLY_COMMAND

      delete_cart(selected_card_index)
      save_context
    end

    def delete_cart(selected_card_index)
      @situation.current_account.card.delete_at(selected_card_index - 1)
    end
  end
end