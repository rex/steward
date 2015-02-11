class Services::Github
  def initialize
    @api_key = Figaro.env.github_api_token
    @client = Github.new basic_auth: "#{@api_key}:"
  end

  def organizations
    @client.orgs.list
  end

  def repos(org_name = nil)
    if(org_name)
      @client.repos.list org: org_name
    else
      @client.repos.list
    end
  end

  def all_repos
    repositories = HashWithIndifferentAccess.new

    organizations.each do |org|
      org_repos = repos org.login
      repositories.store(org.login, org_repos)
    end

    repositories
  end
end