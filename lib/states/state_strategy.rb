class StateStrategy
  CREATE_ACCOUNT_COMMAND = 'create'.freeze
  LOAD_ACCOUNT_COMMAND = 'load'.freeze
  DELETE_ACCOUNT_COMMAND = 'DA'.freeze
  SHOW_CARDS_COMMAND = 'SC'.freeze
  CREATE_CARD_COMMAND = 'CC'.freeze
  DELETE_CARD_COMMAND = 'DC'.freeze
  PUT_MONEY_COMMAND = 'PM'.freeze
  WITHDRAW_MONEY_COMMAND = 'WM'.freeze
  SEND_MONEY_COMMAND = 'SM'.freeze

  def state(command, situation)
    case command
    when CREATE_ACCOUNT_COMMAND then States::CreateAccount.new(situation)
    when LOAD_ACCOUNT_COMMAND then States::LoadAccount.new(situation)
    else ...........
    end
  end