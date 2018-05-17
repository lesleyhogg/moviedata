require 'open-uri'
require 'json'
require 'net/http'

class MoviesController < ApplicationController
  def index
      today = Date.today.to_s
      past = (Date.today - 14).to_s
      api = ENV['TMDB_API_KEY']
      url = 'https://api.themoviedb.org/3/discover/movie?api_key=' + api + '&language=en-US&page=1&region=GR'
      uri = URI(url)
      response = Net::HTTP.get(uri)

      @movies = JSON.parse(response)

      unless @movies['results'].nil?
        @movies['results'].each do |movie|
          #poster_url = 'https://image.tmdb.org/t/p/w500' + movie['poster_path'].to_s
          #poster_uri = URI(url)
          #poster_response = Net::HTTP.get(poster_uri)
          #poster_hash = JSON.parse(poster_response)

          if Movie.where(tmdbid: movie['id'].to_i).empty?
            Movie.create(:title => movie['title'], :description => movie['overview'], :original_title => movie['original_title'], :tmdbid => movie['id'], :release_date => movie['release_date'].to_date, :poster_path => movie['poster_path'])
          end
        end
      end

      @dbmovies = Movie.all
    end
end
