RSpec.describe States::AccountLoad do
  let(:state) { described_class.new(situation) }
  let(:apply) { 'y' }
  let(:disapply) { 'n' }
  let(:account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:situation) { instance_double('Situation', accounts: []) }
  let(:accounts) { [account] }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '98765' }
  let(:wrong_password) { '987654' }
  let(:age) { '54' }

  describe '#step' do
    context 'create account' do
      it do
        state.instance_variable_set(:@answer, apply)
        expect(state.step).to be_a(States::CreateAccount)
      end
    end

    context 'menu acccount state' do
      before do
        allow(situation).to receive(:accounts).and_return(accounts)
      end

      it do
        expect(state.step).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    context 'without account' do
      before do
        allow(state).to receive(:read_input).and_return(apply)
      end

      it do
        expect { state.action }
      end
    end

    context 'with account' do
      before do
        allow(situation).to receive_messages(extant_account: nil, 'extant_account=': account, accounts: accounts)
        allow(state).to receive(:read_input).and_return(login, password)
      end

      it do
        expect { state.action }
      end
    end
  end
end
