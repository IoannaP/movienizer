require 'open-uri'
require 'json'

class MoviesController < ApplicationController

	def show
		json_string = movie_request(params[:movie_id])
		@movie = movie_query(json_string)
		@reviews = Movie.select("review").where("movie_id = ?",params[:movie_id])
	end

	private

	#intoarce stringul in format JSON returnat de api
	#pentru filmul care are id-ul 'id'
	def movie_request( id )

		#adresa nativa a api-ului (fara alte proprietati pentru query)
		apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
		#key-ul pentru api	
		#TODO: change api key when this is ready
		apikey = 'haak3yvy8dsw4gfxu8vprvnv'

		#se formeaza link-ul pentru api cu informatiile de mai sus
		@link = apilink + 'movies/' + id.to_s + '.json?apikey=' + apikey

		#se preia codul HTML (in cazul nostru codul este formatat ca json, 
		#dar se foloseste tot protocolul HTTP care intoarce in mod normal
		#un text in format html) returnat de api
		search_string = URI.parse(@link).read

	end

	#intoarce o structura recursiva de tip hash de hash-uri
	#in care se pastreaza informatiile despre filme
	def movie_query( json_string )

		#se parsseaza json-ul in structura recursiva descrisa
		#anterior si o intoarce ca rezultat al metodei
		parsed_json = JSON.parse(json_string)

	end

end
