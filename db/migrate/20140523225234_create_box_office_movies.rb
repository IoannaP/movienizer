class CreateBoxOfficeMovies < ActiveRecord::Migration
  def change
    create_table :box_office_movies do |t|
      t.string :title
      t.string :rotten_tomatoes_id
      t.string :thumbnail_poster_link

      t.timestamps
    end
  end
end
