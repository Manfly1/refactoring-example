RSpec.describe States::MoneyWithdraw do
  let(:state) { described_class.new(context) }
  let(:context) { instance_double('Storage', accounts: []) }
  let(:amount) { '100' }
  let(:big_amount) { '1000' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '987654' }
  let(:age) { '54' }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:card_number) { '1234555512345555' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:cards) { [card] }
  let(:right_tax) { 1 }
  let(:without_active_cards) { 'no active cards' }
 

  describe '#next' do
    context 'return menu state' do
      it do
        expect(state.next).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    context 'success' do
      before do
        allow(card).to receive(:balance).and_return(big_amount.to_i)
        allow(extant_account).to receive(:card).and_return(cards)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, amount)
        allow(state).to receive(:withdraw_tax).and_return(0)
        allow(context).to receive(:save)
        allow(card).to receive(:balance=)
      end

      it 'when all right' do
        state.action
        expect(context).to have_received(:save)
      end
    end

    context 'false' do
      before do
        allow(context).to receive(:extant_account).and_return(extant_account)
      end

      it 'without active cards' do
        expect { state.action }.to output(/#{without_active_cards}/).to_stdout
      end
    end
  end
end
