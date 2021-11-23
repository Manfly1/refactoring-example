module States
  class MoneyWithdraw < BaseState
    def step
      MenuAccount.new(@situation)
    end

    def action
      puts I18n.t(:withdraw_money_message)
      return unless account_have_cards?(@situation.extant_account.card)

      select_card_step
    end

    private

    def select_card_step
      print_cards(@situation.extant_account.card)
      @selected_card_index = read_input.to_i
      return unless card_index_valid?(@selected_card_index, @situation)

      read_amount_step
    end

    def tax_step
      @withdraw_tax_amount = withdraw_tax(@extant_card.type, @amount)
      @money_left = @extant_card.balance - @amount - @withdraw_tax_amount
      return unless balance_valid?(@money_left)

      save_balance_step
    end

    def read_amount_step
      @selected_card_index -= 1
      @extant_card = @situation.account.card[@selected_card_index]
      @amount = read_input_with_title(I18n.t(:withdraw_amount_message)).to_i
      return unless amount_valid?(@amount)

      tax_step
    end

    def save_balance_step
      @extant_card.balance = @money_left
      @situation.extant_account.card[@selected_card_index] = @extant_card
      @situation.save
      situation(@amount, @extant_card.number, @money_left, @withdraw_tax_amount)
    end
  end
end
