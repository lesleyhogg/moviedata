module MovieHelper
  def format_directors(directors)
    director_hash = []
    split_hash = directors.split(",")

    split_hash.each_with_index do |name, index|
      if index.even?
        director_hash.push([name, hash[index+1]])
      end
    end
    director_hash
  end
end
