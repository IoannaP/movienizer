class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :rotten_tomatoes_id
      t.string :title
      t.string :thumbnail_poster_link
      t.string :detailed_poster_link

      t.timestamps
    end
  end
end
