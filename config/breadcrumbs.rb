crumb :about do
  link "サイト概要", about_path
end

crumb :user_show do |user|
    link "#{user.name}さんの詳細", user_path(user)
    parent :about
end

crumb :user_edit do |user|
    link "ユーザー編集"
    parent :user_show, user
end

crumb :user_like do |user|
    link "いいね"
    parent :user_show, user
end

crumb :user_followings do |user|
    link "フォロワー"
    parent :user_show, user
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).