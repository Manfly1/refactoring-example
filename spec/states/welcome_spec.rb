RSpec.describe States::Welcome do

  let(:state) { described_class.new(situation) }
  let(:situation) { instance_double('Situation', load_accounts: []) }

  describe 'action' do
    it 'has reseived load accounts' do
      state.action
      expect(situation).to have_received(:load_accounts)
    end
  end
end