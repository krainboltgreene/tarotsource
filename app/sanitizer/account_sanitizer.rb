class AccountSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name])
    permit(:account_update, keys: [:reader])
  end
end
