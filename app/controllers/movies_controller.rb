# frozen_string_literal: true

# Index controller
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find params[:id]
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find params[:id]

    @movie.update(movie_params)

    redirect_to @movie
  end

  def movie_params
    @movie = params.require(:movie)
    .permit(:title, :description, :rating, :released_on, :total_gross)
  end
end
