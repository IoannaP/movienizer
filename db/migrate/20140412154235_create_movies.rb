class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :movie_id
      t.string :rating
      t.text :review

      t.timestamps
    end
  end
end
