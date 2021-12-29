RSpec.describe States::MoneyWithdraw do
  let(:state) { described_class.new(context) }
  let(:context) { instance_double('Context', accounts: []) }
  let(:amount) { '100' }
  let(:big_amount) { '1000' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, cards: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '987654' }
  let(:age) { '54' }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:card_number) { '1234555512345555' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:cards) { [cards] }
  let(:right_tax) { 1 }
  let(:no_active_cards) { 'There is no active cards' }

  describe '#next' do
    context 'return menu state' do
      it do
        expect(state.next).to be_a(States::MenuAccount)
      end
    end
  end
end
