class PeopleController < ApplicationController

  require 'csv'
  require 'will_paginate/array'
  include PeopleHelper
  def index
    @people = Person.all.search(params[:search])
    @people = @people.order("#{sort_column} #{sort_direction}").paginate(:page => params[:page], :per_page => 10) if @people.present?
  end

  def upload_file
    # Check if file was provided.
    if params[:file]
      file = File.open(params[:file])
      # Handling if file not CSV/Readable
      begin
      result = []
        row_count = 1
        CSV.foreach(file.path).each do |row|
          #  Check for Header / Affiliation
            result << Person.parse_row(row) unless row_count == 1
          row_count += 1
        end
      rescue e
        flash = "<style='color:red'>Could not read from file, please upload CSV file only.</style>"
        Rails.logger.info(e)
      end
      Rails.logger.info(result)
      flash[:notice] = result
      redirect_to people_path
    end
  end

  def destroy
    @person = Person.find(params[:id])
    if @person.delete
    else

    end
    redirect_back(fallback_location: people_path)
  end





end
