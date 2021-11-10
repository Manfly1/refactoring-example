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

  def state(command, situation)
    case command
    when LOAD_ACCOUNT_COMMAND then States::AccountLoad.new(situation)
    when CREATE_ACCOUNT_COMMAND then States::CreateAccount.new(situation)
    else menu_state(command, situation)
    end
  end

  def card_state(command, situation)
    case command
    when SHOW_CARDS_COMMAND then States::ShowCards.new(situation)
    when DESTROY_CARD_COMMAND then States::DestroyCard.new(situation)
    when CREATE_CARD_COMMAND then States::CreateCard.new(situation)
       else money_operations_state(command, situation)
    end
  end

  def money_operations_state(command, situation)
    case command
      when WITHDRAW_MONEY_COMMAND then States::MoneyWithdraw.new(situation)
    when SEND_MONEY_COMMAND then States::SendMoney.new(situation)
    when PUT_MONEY_COMMAND then States::PutMoney.new(situation)
    else raise NotEnoughMoneyError
    end
  end

  def menu_state(command, situation)
    return States::DestroyAccount.new(situation) if command == DESTROY_ACCOUNT_COMMAND
    card_state(command, situation)
  end
end