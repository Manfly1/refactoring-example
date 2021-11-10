module States
  class MenuAccount < BaseState
    def action
      puts I18n.t(:main_menu_message, name: @situation.account.name)
    end
  end
end