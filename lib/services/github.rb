class Services::Github
  def initialize
    @api_key = Figaro.env.github_api_token
    @client = Octokit::Client.new( :access_token => @api_key )
  end

  def organizations
    @client.organizations
  end

  def repositories
    @client.repositories
  end

  def org_repos(org_name = nil)
    @client.org_repos(org_name)
  end

  def repo_breakdown
    breakdown = {
      personal: {
        repositories: [],
        filesize: 0
      },
      organizations: {},
      stats: {
        filesize: 0
      },
      repositories: []
    }

    repositories.each do |repo|
      breakdown[:personal][:filesize] += repo[:size]
      breakdown[:personal][:repositories] << repo
      breakdown[:repositories] << repo
    end

    organizations.each do |org|
      org_filesize = 0
      repos = org_repos( org[:login] )
      repos.each do |repo|
        org_filesize += repo[:size]
      end

      breakdown[:stats][:filesize] += org_filesize
      breakdown[:organizations][ org[:login] ] = {
        repositories: repos,
        filesize: org_filesize
      }
      breakdown[:repositories].concat(repos)
    end

    breakdown
  end
end