module States
  class Base
    include Helper
    include Validate
    include Statistic
    include Storage

    APPLY_COMMAND = 'y'.freeze

    def initialize(context)
      @context = context
    end

    def action
      raise NotImplementedError
    end

    def next
      Factories::State.new.state(read_input, @context)
    end

    def save_context
      @context.state.save
    end

    def cards
      raise Errors::NoCardsForAccount unless @context.state.extant_account.cards

      @context.state.extant_account.cards
    end
  end
end
