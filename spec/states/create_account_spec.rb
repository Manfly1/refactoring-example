RSpec.describe States::CreateAccount do
  let(:state) { described_class.new(context) }
  let(:context) { instance_double('Storage', accounts: []) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }

  describe '#action' do
    before do
      allow(state).to receive_messages(name_input: 'Andrii', login_input: 'andrii', password_input: '987654',
                                       age_input: '54')
      allow(context).to receive(:extant_account=).and_return(extant_account)
      allow(context).to receive(:extant_account).and_return(extant_account)
      allow(context).to receive(:save)
      state.instance_variable_set(:@context, context)
    end

    context 'saving without errors' do
      it 'save account' do
        state.action
        expect(context).to have_received(:save)
      end
    end

    context 'saving with errors' do
      let(:errors) { ['error'] }

      before do
        allow(extant_account).to receive(:validated?).and_return(false)
        allow(extant_account).to receive(:errors).and_return(errors)
      end

      it 'received errors' do
        state.action
      end
    end
  end

  describe '#next' do
    context 'return MenuAccount state' do
      it 'MenuAccount state' do
        expect(state.next).to be_a(States::MenuAccount)
      end
    end

    context 'return CreateAccount state' do
      it 'has received errors' do
        state.instance_variable_set(:@next_state, States::CreateAccount::CREATE_ACCOUNT_STATE)
        expect(state.next).to be_a(described_class)
      end
    end
  end
end
