module States
  class MenuAccount < Base
    def action
      puts I18n.t(:main_menu_message, name: @context.extant_account.name)
    end
  end
end
