module States
  class Welcome < Base
    def action
      puts I18n.t(:hello)
      @context.base.load_accounts
    end
  end
end
