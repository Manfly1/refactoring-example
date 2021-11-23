RSpec.describe States::MenuAccount do
  let(:extant_account) { instance_double('Account') }
  let(:situation) { instance_double('Sit', extant_account: extant_account) }
  let(:state) { described_class.new(situation) }

  describe 'action' do
    it 'load accounts' do
      state.instance_variable_set(:@situation, situation)
      expect { state.action }
    end
  end
end
