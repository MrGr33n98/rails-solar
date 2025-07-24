module ControllerMacros
  def login_user_helper
    @user = FactoryBot.create(:user)
    sign_in @user
  end
end