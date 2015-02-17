class HomeController < ApplicationController
  def index
    gh = Services::Github.new
    # @orgs = gh.organizations
    # @repos = gh.repositories
    @breakdown = gh.repo_breakdown
  end
end
