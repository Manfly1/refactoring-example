RSpec.describe State do
  CREATE_ACCOUNT_COMMAND = 'create'.freeze
  LOAD_ACCOUNT_COMMAND = 'load'.freeze
  DESTROY_ACCOUNT_COMMAND = 'DA'.freeze
  SHOW_CARDS_COMMAND = 'SC'.freeze
  CREATE_CARD_COMMAND = 'CC'.freeze
  DESTROY_CARD_COMMAND = 'DC'.freeze
  PUT_MONEY_COMMAND = 'PM'.freeze
  WITHDRAW_MONEY_COMMAND = 'WM'.freeze
  SEND_MONEY_COMMAND = 'SM'.freeze

  let(:situation) { instance_double('Situation') }

  describe 'state' do
    it 'create account state' do
      expect(subject.state(CREATE_ACCOUNT_COMMAND, situation)).to be_a(States::CreateAccount)
    end

    it 'account load state' do
      expect(subject.state(LOAD_ACCOUNT_COMMAND, situation)).to be_a(States::AccountLoad)
    end

    it 'destroy account state' do
      expect(subject.state(DESTROY_ACCOUNT_COMMAND, situation)).to be_a(States::DestroyAccount)
    end

    it 'show cards state' do
      expect(subject.state(SHOW_CARDS_COMMAND, situation)).to be_a(States::ShowCards)
    end

    it 'create card state' do
      expect(subject.state(CREATE_CARD_COMMAND, situation)).to be_a(States::CreateCard)
    end

    it 'destroy card state' do
      expect(subject.state(DESTROY_CARD_COMMAND, situation)).to be_a(States::DestroyCard)
    end

    it 'put money state' do
      expect(subject.state(PUT_MONEY_COMMAND, situation)).to be_a(States::PutMoney)
    end

    it 'withdraw money state' do
      expect(subject.state(WITHDRAW_MONEY_COMMAND, situation)).to be_a(States::MoneyWithdraw)
    end

    it 'send money state' do
      expect(subject.state(SEND_MONEY_COMMAND, situation)).to be_a(States::SendMoney)
    end
  end
end
