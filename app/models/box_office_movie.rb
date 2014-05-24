class BoxOfficeMovie < ActiveRecord::Base
	validates_presence_of :rotten_tomatoes_id, :title
end
