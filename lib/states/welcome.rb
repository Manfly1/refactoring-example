module States
  class Welcome < Base
    def action
      puts I18n.t(:hello)
      @context.state.load_accounts
    end
  end
end
