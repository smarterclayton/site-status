class AdminIssuesController < IssuesController
  def new
    @issue = Issue.new
    @issue.updates.new
  end
  def create
    @issue = Time.use_zone(params[:issue][:timezone]) do
      Issue.new params[:issue]
    end
    logger.debug "#{params.inspect} #{params[:scheduled]}"
    @issue.unschedule unless params[:scheduled]
    @issue.updates << Update.new(params[:update])
    if @issue.save
      redirect_to admin_issues_path
    else
      render :new
    end
  end
  def edit
    @issue = Issue.find(params[:id], :include => :updates)
    #@issue.begins_at = @issue.begins_at.in_time_zone(@issue.timezone)
    @update = @issue.updates.new
  end
  def update
    @issue = Issue.find(params[:id], :include => :updates)
    Time.use_zone(params[:issue][:timezone]) do
      @issue.attributes = params[:issue]
      @issue.unschedule unless params[:scheduled]
    end
    if @issue.save
      redirect_to admin_issues_path
    else
      @update = @issue.updates.new
      render :edit
    end
  end

  def editable?
    true
  end
end
