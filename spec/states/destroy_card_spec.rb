RSpec.describe States::DestroyCard do
  let(:state) { described_class.new(situation) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }
  let(:situation) { instance_double('Sit') }
  let(:cards) { [instance_double('Universal', number: '4444111122225555', type: 'virtual')] }
  let(:card_index) { 7 }
  let(:wrong_index) { 357 }

  describe '#destroy card' do
    context 'when card valid' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
        allow(situation).to receive(:extant_account).and_return(extant_account)
      end

      it do
        state.instance_variable_set(:@next_state, States::DestroyCard::MENU_STATE)
        expect(state.step).to be_a(States::MenuAccount)
      end
    end

    context 'when card invalid' do
      before do
        allow(situation).to receive(:extant_account).and_return(extant_account)
      end

      it do
        state.instance_variable_set(:@selected_card_index, card_index)
        expect(state.step).to be_a(described_class)
      end
    end
  end
end
