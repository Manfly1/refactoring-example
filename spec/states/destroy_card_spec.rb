RSpec.describe States::DestroyCard do
  let(:state) { described_class.new(context) }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '54' }
  let(:context) { instance_double('Context') }
  let(:apply) { 'y' }
  let(:cards) { [instance_double('Card', number: card_number, type: card_type)] }
  let(:card_type) { 'usual' }
  let(:card_index) { 1 }
  let(:card_number) { '1111222233334444' }
  let(:card_index) { 7 }
  let(:wrong_index) { 357 }

  describe '#destroy card' do
    before do
      allow(extant_account).to receive(:card).and_return(cards)
      allow(context).to receive(:extant_account).and_return(extant_account)
    end
    context 'success' do
  
      it 'when card valid' do
        expect(state.next).to be_a(States::MenuAccount)
      end

      context 'with cards right index' do
        before do
          allow(state).to receive(:read_input).and_return(card_index, apply)
          allow(context).to receive(:save)
        end
  
        it do
          state.action
          expect(extant_account.card).not_to be_empty
        end
      end
    end
end
end


