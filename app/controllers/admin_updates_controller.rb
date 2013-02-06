class AdminUpdatesController < ApplicationController
  def update
    update = Update.find(params[:id])
    @issue = update.issue
    update = @issue.updates.find{ |u| u == update }
    update.attributes = params[:update]
    if update.save
      redirect_to edit_issue_path(@issue)
    else
      render 'admin_issues/edit'
    end
  end
  def create
    @update = Update.new params[:update]
    @issue = Issue.find(@update.issue_id, :include => :updates)
    ActiveRecord::Base.transaction do
      @issue.updates << @update
      @issue.resolved_at = @update.created_at if params[:resolve]
      if @issue.save
        redirect_to admin_issues_path
      else
        render 'admin_issues/edit'
      end
    end
  end
end
