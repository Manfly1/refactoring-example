module States
  class BaseState

    APPLY_COMMAND = 'y'.freeze

    def initialize(situation)
      @situation = situation
    end

    def action
      raise NotImplementedError
    end

    def next
      BaseState.new.state(read_input, @situation)
    end

    def save_context
      @situation.save
    end
  end
end