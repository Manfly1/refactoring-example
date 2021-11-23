RSpec.describe States::MoneyWithdraw do
  let(:wrong_amount) { '0' }
  let(:not_exist_card_number) { '1111222233334444' }
  let(:wrong_card_number) { '123456' }
  let(:amount) { '100' }
  let(:big_amount) { '1000' }
  let(:disapply) { 'n' }
  let(:state) { described_class.new(situation) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '987654' }
  let(:wrong_password) { '98765412' }
  let(:age) { '54' }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:situation) { instance_double('Situation', accounts: []) }
  let(:card_number) { '1234555512345555' }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:wrong_index) { 123 }
  let(:card) { instance_double('Card', number: card_number, type: card_type, balance: 0) }
  let(:cards) { [card] }
  let(:right_tax) { 1 }

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
        expect { state.action }
      end
    end

    context 'wrong card index' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(situation).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(wrong_index)
      end

      it do
        expect { state.action }
      end
    end

    context 'success' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(situation).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, wrong_amount)
      end

      it do
        expect { state.action }
      end
    end

    context 'wrong number cards' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(situation).to receive(:extant_account).and_return(extant_account)
        allow(state).to receive(:read_input).and_return(card_index, amount)
      end

      it do
        expect { state.action }
      end
    end
  end
end
