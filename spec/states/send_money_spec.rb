RSpec.describe States::SendMoney do
  let(:state) { described_class.new(context) }
  let(:wrong_amount) { '0' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:context) { instance_double('Context', accounts: []) }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:card_number) { '1234567812345678' }
  let(:wrong_card_number) { '85156' }
  let(:not_exist_card_number) { '1111222233334444' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:cards) { [card] }
  let(:wrong_card_number_msg) { 'input correct number' }

  describe '#action' do

    context 'wrong_card_number' do
      before do
        allow(extant_account).to receive(:cards).and_return(cards)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, wrong_card_number)
      end

      it do
        expect { state.action }.to output(/#{wrong_card_number_msg}/).to_stdout
      end
    end
  end
end
