require 'json'
class HomeController < ApplicationController
	public
	attr_accessor :search
	
	def initialize
		super
		@search = Search.new
	end

	def get_search
		return @search
	end

  def index
  	if params[:devise]
  		@devise = Devise.find(params[:devise])
		elsif params[:movie_name]
			@movies = @search.search_movie_by_name(params)
  	elsif params[:devises]
  		@devises = Devise.all
  	end
  end

  def get_devise_by_name
  	@devise = Devise.find_by(name: params[:devise_name])
  	params = {}

  	if @devise
  		params = { devise: @devise.id }
  	else
  		flash[:danger] = "Failure, this devise does not exists."
  	end

  	redirect_to controller: 'home', action: 'index', params: params
  end

  def get_all
  	redirect_to controller: 'home', action: 'index', devises: true
  end
end
