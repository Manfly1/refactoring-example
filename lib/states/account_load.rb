module States
  class AccountLoad < Base
    def action
      if empty_account?
        puts I18n.t(:no_active_account_message)
        return @answer = read_input
      end
      read_login = read_input_with_title(puts(I18n.t(:login_message)))
      read_password = read_input_with_title(puts(I18n.t(:password_message)))

      login = read_login
      password = read_password
      @context.extant_account = get_account(login, password)
      puts I18n.t(:no_account_message) unless @context.extant_account
    end

    def next
      return States::CreateAccount.new(@context) if @answer == APPLY_COMMAND
      return States::Welcome.new(@context) if empty_account? && @answer != APPLY_COMMAND

      MenuAccount.new(@context)
    end

    private

    def empty_account?
      @context.accounts.empty?
    end

    def get_account(login, password)
      @context.accounts.detect { |account| account.login == login && account.password == password }
    end
  end
end
