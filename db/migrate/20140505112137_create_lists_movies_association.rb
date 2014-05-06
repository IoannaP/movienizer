class CreateListsMoviesAssociation < ActiveRecord::Migration
  def change
    create_table :lists_movies_associations, id: false do |t|
    	t.belongs_to :list
    	t.belongs_to :movie
    end
  end
end
