class CreateListMoviePairs < ActiveRecord::Migration
  def change
    create_table :list_movie_pairs do |t|
    	t.belongs_to :list, :movie
    	
      t.timestamps
    end
  end
end
