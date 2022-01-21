module States
  class DestroyAccount < Base
    def action
      @answer = read_input_with_title(I18n.t(:destroy_account_message))
      if apply_command?
        @context.accounts.delete_if { |account| account.login == @context.extant_account.login }
        @context.save
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
