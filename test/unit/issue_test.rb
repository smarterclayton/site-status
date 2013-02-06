require File.expand_path('../../test_helper', __FILE__)

class IssueTest < ActiveSupport::TestCase
  test 'open an issue' do
    assert_difference('Issue.resolved.length', 0) do
      assert_difference('Issue.unresolved.length') do
        issue = Issue.new :title => 'My first issue'
        assert issue.save
      end
    end
  end

  test 'resolving an issue' do
    assert_difference('Issue.resolved.length') do
      issue = Issue.create :title => 'My first issue'

      assert !issue.resolve
      assert issue.errors[:updates].any?{ |s| s =~ /No update was provided/ }

      issue.updates << Update.new(:description => 'the problem has been fixed')
      assert issue.resolve
      assert issue.errors.empty?
    end
  end
end
