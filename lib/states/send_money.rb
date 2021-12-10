module States
  class SendMoney < Base
    def action
      puts I18n.t(:send_money_message)
      return unless account_have_cards?(@context.extant_account.card)

      select_card_step
    end

    def next
      MenuAccount.new(@context)
    end

    private

    def select_card_step
      print_cards(@context.extant_account.card)
      selected_card_index = read_input.to_i
      return unless card_index_valid?(selected_card_index, @context)

      selected_card_index -= 1
      @sender_card = @context.extant_account.card[selected_card_index]
      receiver_card_number_step
    end

    def receiver_card_step
      @receiver_card = card_by_number(@receiver_card_number)
      return unless card_exists?(@receiver_card, @receiver_card_number)

      amount_step
    end

    def receiver_card_number_step
      @receiver_card_number = read_input_with_title(I18n.t(:receiver_card))
      return unless card_length_valid?(@receiver_card_number)

      receiver_card_step
    end

    def amount_step
      @amount = read_input_with_title(I18n.t(:withdraw_amount_message)).to_i
      return unless amount_valid?(@amount)

      taxes_step
    end

    def taxes_step
      @sender_tax_amount = sender_tax(@sender_card.type, @amount)
      @receiver_tax_amount = put_tax(@receiver_card.type, @amount)
      @sender_balance = @sender_card.balance - @amount - @sender_tax_amount
      @receiver_balance = @receiver_card.balance + @amount - @receivertax_amount
      return unless balance_valid?(@sender_balance)
      return unless receiver_tax_valid?(@receiver_tax_amount, @amount)

      save_balances_step
    end

    def save_balances_step
      @sender_card.balance = @sender_balance
      @receiver_card.balance = @receiver_balance
      @context.save
      withdraw_stats(@amount, @sender_card.number, @sender_balance, @sender_tax_amount)
      put_stats(@amount, @rreceiver_card_number, @receiver_balance, @receiver_tax_amount)
    end

    def receiver_tax_valid?(receiver_tax_amount, input_amount)
      return true if receiver_tax_amount < input_amount

      puts I18n.t(:not_enough_money_error)
      false
    end

    def card_by_number(card_number)
      @context.accounts.flat_map(&:card).detect { |card| card.number == card_number }
    end

    def card_exists?(card, _card_number)
      return true unless card.nil?

      puts I18n.t(:no_card_with_number_message)
      false
    end

    def card_length_valid?(card_number)
      return true if card_number.length.between?(15, 17)

      puts I18n.t(:invalid_card_number_message)
      false
    end

    def put_tax(type, amount)
      Entities::PutTax.new(type).tax(amount)
    end

    def send_tax(type, amount)
      Entities::SendTax.new(type).tax(amount)
    end
  end
end
