module Entities
  class CardFactory
    CARDS = {
      usual: {
        type: 'usual',
        balance: 50.00
      },
      capitalist: {
        type: 'capitalist',
        balance: 100.00
      },
      virtual: {
        type: 'virtual',
        balance: 150.00
      }
    }.freeze

    def self.card(card_type)
      return false unless CARDS.key?(card_type)

      Entities::Card.new(CARDS[card_type])
    end
  end
end
