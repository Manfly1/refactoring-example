RSpec.describe States::PutMoney do
  let(:amount) { '100' }
  let(:disapply) { 'n' }
  let(:state) { described_class.new(situation) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:situation) { instance_double('Storage', accounts: []) }
  let(:card_number) { '1234567812345678' }
  let(:card_type) { 'usual' }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:cards) { [card] }
  let(:without_active_cards) { 'no active cards' }

  describe 'step' do
    context 'return menu state' do
      it do
        expect(state.step).to be_a(States::MenuAccount)
      end
    end
  end

  describe 'action' do
    context 'without active cards' do
      before do
        allow(situation).to receive(:extant_account).and_return(extant_account)
      end

      it do
        expect { state.action }.to output(/#{without_active_cards}/).to_stdout
      end
    end

    context 'success' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(situation).to receive(:extant_account).and_return(extant_account)
        allow(situation).to receive(:save)
        allow(state).to receive(:read_input).and_return(card_number, amount)
        allow(card).to receive(:balance=)
      end

      it do
        expect { state.action }.to output(/#{card_number}/).to_stdout
      end
    end
  end
end
