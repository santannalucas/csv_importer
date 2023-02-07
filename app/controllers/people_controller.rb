class PeopleController < ApplicationController

  require 'csv'
  require 'will_paginate/array'
  def index
    @people = Person.paginate(:page => params[:page], :per_page => 10)
  end

  def upload_file
    # Check if file was provided.
    if params[:file]
      file = File.open(params[:file])
      # Handling if file not CSV/Readable
      # begin
      result = []
        row_count = 1
        CSV.foreach(file.path).each do |row|
          #  Check for Header / Affiliation
          unless row_count == 1 || !row[4].present?
            result << parse_row(row)
          end
          row_count += 1
        end
        #rescue e
        #Rails.logger.info('Could not read from file, please upload CSV file only.')
        # Rails.logger.info(e)
        #end
      Rails.logger.info(result)
      flash[:notice] = result.join('<br>')
      redirect_to people_path
    end
  end

  def parse_row(row)
    last_name = row[0].split(' ').size > 1 ? row[0].split(' ').last.titleize : ''
    first_name = row[0].titleize.gsub(last_name,'')
    @person = Person.where(first_name:first_name,last_name:last_name).first_or_initialize
    @person.assign_attributes(
      species:row[2],
      gender:row[3],
      weapon:row[5],
      vehicle:row[6]
    )
    if @person.save
      @person.affiliations.where(name:row[4].titleize).first_or_create
      @person.locations.where(name:row[1].titleize).first_or_create
    end
    " #{first_name.titleize + last_name.titleize}: #{@person.errors.present? ? "ERROR: #{@person.errors.full_messages}" : 'Success'}"
  end
end
