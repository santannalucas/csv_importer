class PeopleController < ApplicationController

  require 'csv'
  require 'will_paginate/array'
  def index
    @people = Person.all
  end

  def upload_file
    # Check if file was provided.
    if params[:file]
      file = File.open(params[:file])
      # Handling if file not CSV/Readable
      # begin
        errors = []
        row_count = 1
        CSV.foreach(file.path).each do |row|
          Rails.logger.info(row_count)
          unless row_count == 1
            # Check for Affiliation
            if row[4].present?
            last_name = row[0].split(' ').last.underscore
            first_name = row[0].underscore.gsub(last_name,'')
            @person = Person.where(first_name:first_name,last_name:last_name).first_or_initialize
            @person.assign_attributes(species:row[2],gender:[3],weapon:[5],vehicle:[6])
            @person.save
            errors << @person.errors.full_messages if @person.errors.present?
            end
          end
          row_count += 1
        Rails.logger.info(errors)
        end
        #rescue e
        #Rails.logger.info('Could not read from file, please upload CSV file only.')
        # Rails.logger.info(e)
        #end
      Rails.logger.info("Wow")
      redirect_to people_path
    end
  end

  def parse_row(row)


  end
end
