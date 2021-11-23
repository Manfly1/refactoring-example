module States
  class Welcome < BaseState
    def action
      puts I18n.t(:hello)
      @situation.load_accounts
    end
  end
end
