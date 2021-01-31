# frozen_string_literal: true

# Index controller
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
end
