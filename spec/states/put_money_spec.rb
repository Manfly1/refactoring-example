RSpec.describe States::PutMoney do
  let(:state) { described_class.new(context) }
  let(:amount) { '100' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:context) { instance_double('Context', accounts: []) }
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
end
