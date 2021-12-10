module States
  class DestroyAccount < Base
    def action
      puts I18n.t(:destroy_account_message)
      @answer = read_input
      if apply_command
        @context.accounts.delete_if { |account| account.login == @context.extant_account.login }
        @context.save
      end
    end

    def next
      return Base.new(@context) if apply_command

      MenuAccount.new(@context)
    end

    private

    def apply_command
      @answer == APPLY_COMMAND
    end
  end
end
