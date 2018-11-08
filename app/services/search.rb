require 'open-uri'
require 'net/http'
require 'uri'
require 'json'
require 'date'
require 'bundler'
Bundler.require
require 'dotenv'
Dotenv.load

class Search
		def search_movie_by_name(params)
			data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/search/movie?api_key="+ENV['API_KEY']+"&query="+params[:movie_name]))
			data = JSON.parse(data)
			movies = []

			data['results'].each do |line|
	  		movie = Movie.new
	  		movie.original_title = line['original_title']
	  		credits = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/movie/"+ String(line["id"])+"?api_key="+ENV['API_KEY']+"&query="+params[:movie_name]+"&append_to_response=credits"))
	  		credits = JSON.parse(credits)

	  		director = Character.new
	  		director.name = credits['credits']['crew'][0]['name']
	  		director.job = credits['credits']['crew'][0]['job']
	  		director.profile_path = credits['credits']['crew'][0]['profile_path']
	  		
	  		movie.director = director

	  		date = DateTime.parse(line['release_date'])
				date = date.strftime('%d/%m/%Y')
	  		movie.release_date = date

	  		movie.overview = line['overview']
	  		movie.backdrop_path = line['backdrop_path']
	  		movies << movie
	  	end

	  	return movies
		end
end