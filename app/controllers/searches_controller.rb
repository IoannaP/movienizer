require 'open-uri'
require 'json'

class SearchesController < ApplicationController
	def index
		@box_office_res = boxoffice_request
		@movies_box_office = movies_query(@box_office_res)

		if params[:q]
			@search_res = movies_request(params[:q])
			@movies_part = movies_query(@search_res)
		end
	end

	private

	#intoarce stringul in format JSON returnat de api
	#pentru filmele care corespund numelui din 'param'
	def movies_request( param )

		#adresa nativa a api-ului (fara alte proprietati pentru query)
		apilink = 'http://api.rottentomatoes.com/api/public/v1.0/' 
		#key-ul pentru api	
		#TODO: change api key when this is ready
		apikey = 'haak3yvy8dsw4gfxu8vprvnv'
		#numarul de rezultate intoarse de query
		apipagelimit = 'page_limit=10'

		#se inlocuieste toate caracterele considerate 'whitespace'
		#din stringul introdus de utilizator in search bar cu caracterul '+'
		#deoarece aceasta este conventia de utilizare a api-ului
		param.gsub!(/\s/,'+')

		#se formeaza link-ul pentru api cu informatiile de mai sus
		@link = apilink + 'movies.json?apikey=' + apikey + '&q=' + param + '&' + apipagelimit

		#se preia codul HTML (in cazul nostru codul este formatat ca json, 
		#dar se foloseste tot protocolul HTTP care intoarce in mod normal
		#un text in format html) returnat de api
		search_string = URI.parse(@link).read

	end

	#intoarce stringul in format JSON returnat de api
	#pentru filmele din Box Office
	def boxoffice_request

		#adresa nativa a api-ului (fara alte proprietati pentru query)
		apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
		#key-ul pentru api	
		#TODO: change api key when this is ready
		apikey = 'haak3yvy8dsw4gfxu8vprvnv'
		#numarul de rezultate intoarse pentru box-office de query
		apipagelimit = 'limit=10'

		#se formeaza link-ul pentru api cu informatiile de mai sus
		@link = apilink + 'lists/movies/box_office.json?apikey=' + apikey + '&' + apipagelimit

		#se preia codul HTML (in cazul nostru codul este formatat ca json, 
		#dar se foloseste tot protocolul HTTP care intoarce in mod normal
		#un text in format html) returnat de api
		search_string = URI.parse(@link).read		

	end

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

	#intoarce un array in care se pastreaza informatiile despre filmele
	#cuprinse in json-ul 'json_string'
	def movies_query( json_string )

		#se parseaza json-ul intr-o structura recursiva gen
		#hash-uri (din ruby) de hash-uri (sau array-uri, in
		#in functie de configuratia json-ului in acel moment)
		parsed_json = JSON.parse(json_string)

		#se declara array-ul movies in care se va pastra
		#un hash cu detaliile pentru fiecare film in parte
		movies = Array.new

		#se preia fiecare film din parsed_json si se trimite
		#in array-ul movies
		parsed_json['movies'].each do |movie|
			movies.push movie
		end

		#se intoarce array-ul movies
		movies
	end

	#intoarce o structura recursiva de tip hash de hash-uri
	#in care se pastreaza informatiile despre filme
	def movie_query( json_string )

		#se parsseaza json-ul in structura recursiva descrisa
		#anterior si o intoarce ca rezultat al metodei
		parsed_json = JSON.parse(json_string)

	end

end
