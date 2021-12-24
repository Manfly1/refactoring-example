module Storage
  attr_accessor :extant_account, :state, :accounts

  STORAGE_FILE = 'accounts.yml'.freeze

  def save
    File.open(STORAGE_FILE, 'w') { |f| f.write @accounts.to_yaml }
  end

  def load_accounts
    @accounts = File.exist?(STORAGE_FILE) ? YAML.load_file(STORAGE_FILE) : []
  end
end
