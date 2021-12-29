RSpec.describe States::AccountLoad do
  let(:state) { described_class.new(context) }
  let(:apply) { 'y' }
  let(:account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:context) { instance_double('Context', accounts: []) }
  let(:accounts) { [account] }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '98765' }
  let(:age) { '54' }
  let(:without_accounts) { 'no active accounts' }
  let(:login_message) { 'Enter your login' }

  describe '#next' do
    context 'create account' do
      it do
        state.instance_variable_set(:@answer, apply)
        expect(state.next).to be_a(States::CreateAccount)
      end
    end

    context 'menu acccount state' do
      before do
        allow(context).to receive(:accounts).and_return(accounts)
      end

      it do
        expect(state.next).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    context 'without account' do
      before do
        allow(state).to receive(:read_input).and_return(apply)
      end

      it do
        expect { state.action }.to output(/#{without_accounts}/).to_stdout
      end
    end

    context 'with account' do
      before do
        allow(context).to receive_messages(extant_account: nil, 'extant_account=': account, accounts: accounts)
        allow(state).to receive(:read_input).and_return(login, password)
      end

      it do
        expect { state.action }.to output(/#{login_message}/).to_stdout
      end
    end
  end
end
