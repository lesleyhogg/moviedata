
# Pulls data from the TMDB via API
# and saves what is now playing to the database
class MoviesService

  private

  def self.movies_database
    # call API key in the .env file
    api = ENV.fetch('TMDB_API_KEY')
    # parse the url into JSON
    url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=' + api + '&region=GR'
    uri = URI(url)
    # in the future the movie retrieval process should be moved into a background process
    response = Net::HTTP.get(uri)
    @movies = JSON.parse(response)

    # if there are results, pull info from the database hash
    unless @movies['results'].nil?
      @movies['results'].each do |movie|
        if Movie.where(tmdbid: movie['id'].to_i).empty?
          crew_url = 'https://api.themoviedb.org/3/movie/' + movie['id'].to_s + '/credits?api_key=' + api
          crew_uri = URI(crew_url)
          crew_response = Net::HTTP.get(crew_uri)
          crew_hash = JSON.parse(crew_response)
          directors = []
          unless crew_hash['crew'].nil?
            crew_hash['crew'].each do |person|
              if person['job'] == 'Director'
                directors.push(person['name'])
                directors_url = 'https://api.themoviedb.org/3/person/' + person['id'].to_s + '?api_key='+ api
                directors_uri = URI(directors_url)
                directors_response = Net::HTTP.get(directors_uri)
                directors_hash = JSON.parse(directors_response)
                directors.push(directors_hash['imdb_id'])
              end
            end
          end

          Movie.create(:title => movie['title'], :description => movie['overview'], :original_title => movie['original_title'], :tmdbid => movie['id'], :release_date => movie['release_date'].to_date, :poster_path => movie['poster_path'], :directors => directors.join(","))
        end
      end
    end
  end
end
