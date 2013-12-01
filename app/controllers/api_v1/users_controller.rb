module ApiV1
  class UsersController < ApiController
    def create
      @user = CreatesUser.new(user_params).create_with_access_token
      @authentication = UserAuthentication.new(@user)

      respond_with(@user, status: :created)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
