RSpec.describe States::State do
  let(:situation) { instance_double('Storage') }

  describe 'state' do
    it 'create account state' do
      expect(subject.state('create', situation)).to be_a(States::CreateAccount)
    end

    it 'account load state' do
      expect(subject.state('load', situation)).to be_a(States::AccountLoad)
    end

    it 'destroy account state' do
      expect(subject.state('DA', situation)).to be_a(States::DestroyAccount)
    end

    it 'show cards state' do
      expect(subject.state('SC', situation)).to be_a(States::ShowCards)
    end

    it 'create card state' do
      expect(subject.state('CC', situation)).to be_a(States::CreateCard)
    end

    it 'destroy card state' do
      expect(subject.state('DC', situation)).to be_a(States::DestroyCard)
    end

    it 'put money state' do
      expect(subject.state('PM', situation)).to be_a(States::PutMoney)
    end

    it 'withdraw money state' do
      expect(subject.state('WM', situation)).to be_a(States::MoneyWithdraw)
    end

    it 'send money state' do
      expect(subject.state('SM', situation)).to be_a(States::SendMoney)
    end
  end
end
