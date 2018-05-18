class AddDirectorToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :directors, :string
    add_column :movies, :imdb_id, :integer
  end
end
