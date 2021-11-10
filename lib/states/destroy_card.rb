module States
  class DestroyCard < BaseState

    MENU_STATE = :main_menu_message

    def action
      return @next_state = MENU_STATE unless account_have_cards?(@situation.account.card)

      select_card
    end

    def next
      return MenuAccount.new(@situation) if @next_state == MENU_STATE

      DestroyCard.new(@situation)
    end

    def select_card
      print_cards(@situation.account.card, I18n.t(:destroy_card_message))
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index, @situation)

      agree_to_delete_cart(selected_card_index)
    end

    def agree_to_delete_cart(selected_card_index)
      puts I18n.t(:destroy_card_message, card_number: @situation.account.card[selected_card_index - 1].number)
      return unless read_input == APPLY_COMMAND

      delete_cart(selected_card_index)
      save_situation
    end

    def delete_cart(selected_card_index)
      @situation.account.card.delete_at(selected_card_index - 1)
    end
  end
end