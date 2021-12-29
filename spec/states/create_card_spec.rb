RSpec.describe States::CreateCard do
  USUAL_CARD = 'usual'.freeze
  CAPITALIST_CARD = 'capitalist'.freeze
  VIRTUAL_CARD = 'virtual'.freeze

  let(:state) { described_class.new(context) }
  let(:context) { instance_double('Context') }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, cards: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '123456' }
  let(:age) { '22' }

  describe '#next' do
    context 'with wrong card' do
      before do
        state.instance_variable_set(:@wrong_card, true)
      end

      it 'invalid number for card' do
        expect(state.next).to be_a(described_class)
      end
    end

    describe 'action' do
      before do
        allow(state).to receive(:read_input).and_return(USUAL_CARD)
        allow(context).to receive(:extant_account).and_return(extant_account)
        allow(context).to receive(:save)
        state.instance_variable_set(:@context, context)
      end
  
      it 'has save' do
        state.action
        expect(context).to have_received(:save)
      end
  
      context 'when usual card' do
        before do
          allow(state).to receive(:read_input).and_return(USUAL_CARD)
        end
  
        it do
          state.action
          expect(extant_account.cards.pop.type).to eq(USUAL_CARD)
        end
      end
  
      context 'when capitalist card' do
        before do
          allow(state).to receive(:read_input).and_return(CAPITALIST_CARD)
        end
  
        it do
          state.action
          expect(extant_account.cards.pop.type).to eq(CAPITALIST_CARD)
        end
      end
  
      context 'when virtual card' do
        before do
          allow(state).to receive(:read_input).and_return(VIRTUAL_CARD)
        end
  
        it do
          state.action
          expect(extant_account.cards.pop.type).to eq(VIRTUAL_CARD)
        end
      end
    end
  end
end
