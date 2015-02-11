class HomeController < ApplicationController
  def index
    gh = Services::Github.new
    @orgs = gh.organizations
    @all_repos = gh.all_repos
  end
end
