RSpec.describe States::CreateAccount do
  let(:state) { described_class.new(situation) }
  let(:situation) { instance_double('Situation', accounts: []) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }

  describe '#action' do
    before do
      allow(state).to receive_messages(name_input: 'Andrii', login_input: 'andrii', password_input: '987654',
                                       age_input: '54')
      allow(situation).to receive(:extant_account=).and_return(extant_account)
      allow(situation).to receive(:extant_account).and_return(extant_account)
      allow(situation).to receive(:save)
      state.instance_variable_set(:@situation, situation)
    end

    context 'saving without errors' do
      it 'save account' do
        state.action
        expect(situation).to have_received(:save)
      end
    end

    context 'saving with errors' do
      let(:errors) { ['error'] }

      it 'received errors' do
        state.action
      end
    end
  end

  describe '#step' do
    context 'return MenuAccount state' do
      it 'MenuAccount state' do
        expect(state.step).to be_a(States::MenuAccount)
      end
    end

    context 'return CreateAccount state' do
      it 'has received errors' do
        state.instance_variable_set(:@next_state, States::CreateAccount::CREATE_ACCOUNT_STATE)
        expect(state.step).to be_a(described_class)
      end
    end
  end
end
