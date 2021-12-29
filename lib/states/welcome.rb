module States
  class Welcome < Base
    def action
      puts I18n.t(:hello)
      @context.state.accounts
    end
  end
end
