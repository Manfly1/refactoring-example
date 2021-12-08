RSpec.describe States::SendMoney do
  let(:amount) { '100' }
  let(:wrong_amount) { '0' }
  let(:big_amount) { '1000' }
  let(:disapply) { 'n' }
  let(:state) { described_class.new(context) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:context) { instance_double('Context', accounts: []) }
  let(:card_number) { '1234567812345678' }
  let(:wrong_card_number) { '85156' }
  let(:not_exist_card_number) { '1111222233334444' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:cards) { [card] }
  let(:receiver) do
    instance_double('Account', name: receiver_name, login: receiver_login, password: password, age: age, card: [])
  end
  let(:receiver_name) { 'Andrii' }
  let(:receiver_login) { 'andrii' }
  let(:receiver_cards) { instance_double('Card', number: receiver_card_number, type: card_type, balance: 0) }
  let(:receiver_card_number) { '4900567812345678' }
  let(:accounts) { [extant_account, receiver] }
  let(:without_active_cards) { 'no active cards' }
  let(:without_money_message) { 'not enough money on card' }
  let(:no_card_message) { 'no card' }
  let(:wrong_card_number_msg) { 'input correct number' }

  describe 'action' do
    context 'without active cards' do
      before do
        allow(context).to receive(:extant_account).and_return(extant_account)
      end

      it do
        expect { state.action }.to output(/#{without_active_cards}/).to_stdout
      end
    end

    context 'wrong_card_number' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, wrong_card_number)
      end

      it do
        expect { state.action }.to output(/#{wrong_card_number_msg}/).to_stdout
      end
    end

    context 'wrong amount' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(receiver).to receive(:card).and_return(receiver_cards)
        allow(context).to receive(:accounts).and_return(accounts)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, receiver_card_number, wrong_amount)
      end

      it do
        expect { state.action }.to output(/#{I18n.t('wrong_money_amount')}/).to_stdout
      end
    end

    context 'wrong number card' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(context).to receive(:accounts).and_return(accounts)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, not_exist_card_number)
      end

      it do
        expect { state.action }.to output(/#{no_card_message}/).to_stdout
      end
    end
  end
end
