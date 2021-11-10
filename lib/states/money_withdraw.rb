module States
  class MoneyWithdraw < BaseState
    def action
      puts I18n.t(:withdraw_money_message)
      return unless account_have_cards?(@situation.account.card)
      select_card_step
    end

    def next
      MenuAccount.new(@situation)
    end

    private

    def select_card_step
      print_cards(@situation.account.card)
      @selected_card_index = read_input.to_i
      return unless card_index_valid?(@selected_card_index, @situation)
      read_amount_step
    end

    def read_amount_step
      @selected_card_index -= 1
      @current_card = @situation.account.card[@selected_card_index]
      @amount = read_input_with_title(I18n.t(:withdraw_amount_message)).to_i
      return unless amount_valid?(@amount)
      tax_step
    end

    def tax_step
      @withdraw_tax_amount = withdraw_tax(@current_card.type, @amount)
      @money_left = @current_card.balance - @amount - @withdraw_tax_amount
      return unless balance_valid?(@money_left)
      save_balance_step
    end

    def save_balance_step
      @current_card.balance = @money_left
      @situation.account.card[@selected_card_index] = @current_card
      @situation.save
      situation(@amount, @current_card.number, @money_left, @withdraw_tax_amount)
    end
  end
end