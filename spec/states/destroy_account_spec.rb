RSpec.describe States::DestroyAccount do
  let(:apply) { 'y' }
  let(:disapply) { 'n' }
  let(:state) { described_class.new(situation) }
  let(:extant_account) { instance_double('Account', name: 'Andrii', login: 'andrii', password: '987654', age: '54') }
  let(:situation) { instance_double('Storage') }
  let(:accounts) { [extant_account] }

  describe '#step' do
    context 'true' do
      it do
        state.instance_variable_set(:@answer, apply)
        expect(state.step).not_to be_a(States::Welcome)
      end
    end

    context 'falsey' do
      it do
        state.instance_variable_set(:@answer, disapply)
        expect(state.step).to be_a(States::MenuAccount)
      end
    end
  end

  describe '#action' do
    before do
      allow(situation).to receive(:extant_account).and_return(extant_account)
      allow(situation).to receive(:accounts).and_return(accounts)
      allow(situation).to receive(:save)
    end

    context 'true' do
      before do
        allow(state).to receive(:read_input).and_return(apply)
      end

      it 'delete current' do
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
