class MoviesController < ApplicationController
  def index
    @release_date = params[:release_date]

    @dbmovies = Movie.order('release_date DESC').limit(21)
  end
end
