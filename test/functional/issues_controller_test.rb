require File.expand_path('../../../test_helper', __FILE__)

class OpenshiftStatus::IssuesControllerTest < ActionController::TestCase
  test 'empty' do
    get :index, :use_route => :openshift_status
    assert_response :success
  end

  test 'one open issue' do
    Issue.create :title => 'Open Issue 1'

    get :index, :use_route => :openshift_status
    assert_response :success
    assert_select '.open .title', 'Open Issue 1'
  end

  test 'one resolved issue' do
    Issue.create :title => 'Open Issue 1'
    Issue.first.updates << Update.new(:description => 'Issue has been closed')
    Issue.first.resolve

    get :index, :use_route => :openshift_status
    assert_response :success
    assert_select '.resolved .title', 'Open Issue 1'
    assert_select '.resolved .update .description', 'Issue has been closed'
  end
end
