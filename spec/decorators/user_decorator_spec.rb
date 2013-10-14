require "draper"
require_relative "../../app/decorators/user_decorator"

describe UserDecorator do
  describe "#avatar_url" do
    it "is the gravatar for the User's email" do
      user = instance_double("User", email: "a@a.com")
      decorated_user = described_class.new(user)

      expect(decorated_user.avatar_url).to \
        eq("https://www.gravatar.com/avatar/d10ca8d11301c2f4993ac2279ce4b930.jpg?s=36&d=mm")
    end
  end
end
