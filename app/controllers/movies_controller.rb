# frozen_string_literal: true

# Index controller
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find params[:id]
  end

  def root
  end
end
