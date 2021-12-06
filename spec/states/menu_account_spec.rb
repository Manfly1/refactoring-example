RSpec.describe States::MenuAccount do
  let(:human_name) { 'Andrii' }
  let(:extant_account) { instance_double('Account', name: human_name) }
  let(:situation) { instance_double('Storage', extant_account: extant_account) }
  let(:state) { described_class.new(situation) }

  describe 'action' do
    it 'load accounts' do
      state.instance_variable_set(:@situation, situation)
      expect { state.action }.to output(/#{human_name}/).to_stdout
    end
  end
end
