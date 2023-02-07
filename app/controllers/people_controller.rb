class PeopleController < ApplicationController

  require 'csv'
  require 'will_paginate/array'
  def index

  end

  def upload_file
    if params[:file]
      file = File.open(params[:file])
      begin
        CSV.foreach(file.path).each do |row|
        Rails.logger.info(row)
        end
      rescue
        Rails.logger.info('Could not read from file, please upload CSV file only.')
      end
      Rails.logger.info("Wow")
      redirect_to people_path
    end
  end

  def parse_row(row)


  end
end
