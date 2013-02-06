class IssuesController < ApplicationController
  def index
    @open = Issue.active.includes(:updates)
    @resolved = Issue.resolved_since(1.month.ago).limit(4).includes(:updates)
    @total_resolved = Issue.resolved.size
    @scheduled = Issue.upcoming
  end

  def archived
    @scheduled = Issue.upcoming
  end
end
