require 'open-uri'
require 'json'
require 'net/http'

class MoviesController < ApplicationController
  def index
    @movies_service = MoviesService.movies_database
    @release_date = params[:release_date]

    @dbmovies = Movie.order('release_date DESC').limit(21)
  end
end
