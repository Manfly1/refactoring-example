module States
  class DestroyAccount < Base
    def action
      puts I18n.t(:destroy_account_message)
      @answer = read_input
      if apply_command?
        @context.state.accounts.delete_if { |account| account.login == @context.state.extant_account.login }
        @context.state.save
      end
    end

    def next
      return States::Welcome.new(@context) unless apply_command?

      MenuAccount.new(@context)
    end

    private

    def apply_command?
      @answer == APPLY_COMMAND
    end
  end
end
