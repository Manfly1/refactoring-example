module States
  class State
    CREATE_ACCOUNT_COMMAND = 'create'.freeze
    LOAD_ACCOUNT_COMMAND = 'load'.freeze
    DESTROY_ACCOUNT_COMMAND = 'DA'.freeze
    SHOW_CARDS_COMMAND = 'SC'.freeze
    CREATE_CARD_COMMAND = 'CC'.freeze
    DESTROY_CARD_COMMAND = 'DC'.freeze
    PUT_MONEY_COMMAND = 'PM'.freeze
    WITHDRAW_MONEY_COMMAND = 'WM'.freeze
    SEND_MONEY_COMMAND = 'SM'.freeze

    def state(command, context)
      case command
      when LOAD_ACCOUNT_COMMAND then States::AccountLoad.new(context)
      when CREATE_ACCOUNT_COMMAND then States::CreateAccount.new(context)
      else menu_state(command, context)
      end
    end

    def card_state(command, context)
      case command
      when SHOW_CARDS_COMMAND then States::ShowCards.new(context)
      when DESTROY_CARD_COMMAND then States::DestroyCard.new(context)
      when CREATE_CARD_COMMAND then States::CreateCard.new(context)
      else money_operations_state(command, context)
      end
    end

    def money_operations_state(command, context)
      case command
      when WITHDRAW_MONEY_COMMAND then States::MoneyWithdraw.new(context)
      when SEND_MONEY_COMMAND then States::SendMoney.new(context)
      when PUT_MONEY_COMMAND then States::PutMoney.new(context)
      else raise Errors::NotEnoughMoneyError
      end
    end

    def menu_state(command, context)
      return States::DestroyAccount.new(context) if command == DESTROY_ACCOUNT_COMMAND

      card_state(command, context)
    end
  end
end
