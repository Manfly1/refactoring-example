RSpec.describe States::DestroyAccount do
  let(:apply) { 'y' }
  let(:disapply) { 'n' }
  let(:state) { described_class.new(context) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }
  let(:context) { instance_double('Context') }
  let(:accounts) { [extant_account] }

  describe '#next' do
    context 'success' do
      it do
        state.instance_variable_set(:@answer, apply)
        expect(state.next).not_to be_a(States::Welcome)
      end
    end

    context 'falsey' do
      it do
        state.instance_variable_set(:@answer, disapply)
        expect(state.next).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    before do
      allow(context).to receive(:extant_account).and_return(extant_account)
      allow(context).to receive(:accounts).and_return(accounts)
      allow(context).to receive(:save)
    end

    context 'success' do
      before do
        allow(state).to receive(:read_input).and_return(apply)
      end

      it 'delete current' do
        state.action
        expect(accounts).to eq([])
      end

      it 'call save' do
        state.action
        expect(context).to have_received(:save)
      end
    end
  end
end
