class PeopleController < ApplicationController

  require 'csv'
  require 'will_paginate/array'
  include PeopleHelper

  def index
    @people = Person.joins(:affiliations, :locations).search(params[:search])
    @people = @people.order("#{sort_column} #{sort_direction}").uniq.paginate(:page => params[:page], :per_page => 10) if @people.present?
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
            result << Person.parse_row(row,row_count) unless row_count == 1
          row_count += 1
        end
        result = result.join(' / ')
      rescue
       result = "<span style='color:red'>Could not read from file, please upload CSV file only.</span>"
      end
    else
      result = "File not Found"
    end
    flash[:notice] = result
    redirect_to people_path
  end

  def destroy
    @person = Person.find(params[:id])
    flash[:notice] = 'Person Deleted.' if @person.delete
    redirect_to person_path
  end

end
