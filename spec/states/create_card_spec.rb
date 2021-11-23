RSpec.describe States::CreateCard do
  USUAL_CARD = 'usual'.freeze
  CAPITALIST_CARD = 'capitalist'.freeze
  VIRTUAL_CARD = 'virtual'.freeze

  let(:state) { described_class.new(situation) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }
  let(:situation) { instance_double('Situation') }

  describe '#step' do
    context 'with wrong card' do
      before do
        state.instance_variable_set(:@wrong_card, true)
      end

      it 'invalid number for card' do
        expect(state.step).to be_a(described_class)
      end
    end

    context 'without wrong card' do
      it { expect(state.step).to be_a(States::MenuAccount) }
    end
  end
end
