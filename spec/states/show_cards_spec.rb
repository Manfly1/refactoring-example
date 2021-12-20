RSpec.describe States::ShowCards do
  let(:state) { described_class.new(context) }
  let(:extant_account) { instance_double('Account', name: name, login: login, password: password, age: age, card: []) }
  let(:name) { 'Andrii' }
  let(:login) { 'andrii' }
  let(:password) { '987654' }
  let(:age) { '54' }
  let(:cards) { [instance_double('Card', number: card_number, type: card_type)] }
  let(:card_number) { '1234555512345555' }
  let(:card_type) { 'usual' }
  let(:context) { instance_double('Storage') }

  describe '#action' do
    before do
      allow(context).to receive(:extant_account).and_return(extant_account)
    end

    context 'without cards' do
      it do
        expect { state.action }.to output(/#{I18n.t('no_active_cards_message')}/).to_stdout
      end
    end

    context 'with cards right index' do
      before do
        allow(extant_account).to receive(:card).and_return(cards)
      end

      it do
        expect { state.action }.to output(/#{card_number}/).to_stdout
      end
    end
  end
end
