class GithubUser
  def self.find_or_initialize(github_access_token)
    github      = Octokit::Client.new(access_token: github_access_token)
    github_user = github.user
    emails      = github.emails(accept: "application/vnd.github.v3")

    user = User.find_or_initialize_by(github_user_id: github_user.id)

    user.github_access_token = github_access_token
    user.email               = emails.find(&:primary?).email
    user.name                = github_user[:name]

    user
  end
end
