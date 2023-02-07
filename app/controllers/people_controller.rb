class PeopleController < ApplicationController

  require 'will_paginate/array'
  def index

  end

  def upload_file
    if params[:file]
      flash = "Wow"
      redirect_to people_path
    end
  end

  def parse_row(row)


  end
end
