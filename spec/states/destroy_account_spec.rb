RSpec.describe States::DestroyAccount do
  let(:agree) { 'y' }
  let(:disagree) { 'n' }
  let(:state) { described_class.new(situation) }
  let(:account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }
  let(:situation) { instance_double('Sit') }
  let(:accounts) { [account] }

  describe '#next' do
    context 'when true' do
      it do
        state.instance_variable_set(:@answer, agree)
        expect(state.next).not_to be_a(States::Welcome)
      end
    end

    context 'when false' do
      it do
        state.instance_variable_set(:@answer, disagree)
        expect(state.next).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    before do
      allow(situation).to receive(:account).and_return(account)
      allow(situation).to receive(:accounts).and_return(accounts)
      allow(situation).to receive(:save)
    end

    context 'when true' do
      before do
        allow(state).to receive(:read_input).and_return(agree)
      end

      it 'destroy current' do
        state.action
        expect(accounts).to eq([])
      end

      it 'call save' do
        state.action
        expect(situation).to have_received(:save)
      end
    end
  end
end