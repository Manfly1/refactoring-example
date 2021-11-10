RSpec.describe States::CreateAccount do
  let(:state) { described_class.new(situation) }
  let(:situation) { instance_double('Situat', accounts: []) }
  let(:account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }

  describe '#action' do
    before do

      allow(state).to receive_messages(name_input: 'Andrii', login_input: 'andrii', password_input: '987654', age_input: '54')
      allow(situation).to receive(:account=).and_return(account)
      allow(situation).to receive(:account).and_return(account)
      allow(situation).to receive(:save)
      state.instance_variable_set(:@situation, situation)
    end

    context 'app started without errors' do
      it 'save' do
        state.action
        expect(situation).to have_received(:save)
      end
    end

    context 'app started with errors' do
      let(:errors) { ['error'] }

      it 'has received errors' do
        state.action
      end
    end
  end

  describe '#next' do
    context 'when return AccountMenu state' do
      it 'AccountMenu state' do
        expect(state.next).to be_a(States::MenuAccount)
      end
    end

    context 'when next_state CreateAccount state' do
      it 'has received errors' do
        state.instance_variable_set(:@next_state, States::CreateAccount::CREATE_ACCOUNT_STATE)
        expect(state.next).to be_a(described_class)
      end
    end
  end
end