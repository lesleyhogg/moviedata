namespace :scheduler do

  # bundle exec rake heroku:reset_db
  desc "Refresh database"
  task :db_refresh => :environment do
    @movies_service = MoviesService.movies_database
  end
=begin
  # Helper functions
  # Source: http://kakimotonline.com/2014/04/27/using-rake-to-automate-heroku-tasks/
  def run_command(cmd, app_name)
    Bundler.with_clean_env do
      sh build_command(cmd, app_name)
    end
  end

  def build_command(cmd, app_name)
    "heroku #{cmd} --app #{app_name}"
  end
=end
end
