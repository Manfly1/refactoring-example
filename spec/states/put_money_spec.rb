RSpec.describe States::PutMoney do
  let(:state) { described_class.new(context) }
  let(:amount) { '100' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:context) { instance_double('Storage', accounts: []) }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:card_number) { '1234567812345678' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:right_tax) { 1 }
  let(:cards) { [card] }
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
        allow(extant_account).to receive(:card).and_return(cards)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(context).to receive(:save)
        allow(state).to receive(:read_input).and_return(card_index, amount)
        allow(state).to receive(:put_tax).and_return(right_tax)
        allow(card).to receive(:balance=)
      end

      it do
        expect { state.action }.to output(/#{card_number}/).to_stdout
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
