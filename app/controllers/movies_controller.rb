require 'open-uri'
require 'json'
require 'net/http'

class MoviesController < ApplicationController
  def index
      #call API key in the .env file
      api = ENV.fetch('TMDB_API_KEY')
      #parse the url into JSON
      url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=' + api + '&region=GR'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      @movies = JSON.parse(response)

      #if there are results, pull info from the database hash
      unless @movies['results'].nil?
        @movies['results'].each do |movie|
          if Movie.where(tmdbid: movie['id'].to_i).empty?
            Movie.create(:title => movie['title'], :description => movie['overview'], :original_title => movie['original_title'], :tmdbid => movie['id'], :release_date => movie['release_date'].to_date, :poster_path => movie['poster_path'])
          end
        end
      end

      @dbmovies = Movie.all
    end
end
