module States
  class Welcome < BaseState
    def action
      puts I18n.t(:hello)
      @context.load_accounts
    end
  end
end
