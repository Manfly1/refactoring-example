module States
  class Welcome < Base
    def action
      puts I18n.t(:hello)
      @context.load_accounts
    end
  end
end
