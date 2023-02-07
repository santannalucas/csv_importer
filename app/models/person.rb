class Person < ActiveRecord::Base

  has_and_belongs_to_many :locations
  has_and_belongs_to_many :affiliations

  validates_uniqueness_of :first_name, scope: :last_name
  validates_presence_of :first_name

  def self.search(search)
    search.present? ? where("first_name LIKE '#{search} ' OR last_name LIKE '#{search}'") : all
  end

  def self.parse_row(row)
    # Build Name
    last_name = row[0].split(' ').size > 1 ? row[0].split(' ').last.titleize : ''
    first_name = row[0].titleize.gsub(last_name,'')
    # Check Affiliation
    if row[4].present?
      # Find Existing to Update or Create New
      @person = Person.where(first_name:first_name,last_name:last_name).first_or_initialize
      @person.assign_attributes(
        species:row[2],
        gender:Person.get_gender(row[3]),
        weapon:row[5],
        vehicle:row[6]
      )
      # Create Affiliations / Locations
      if @person.save
        @person.affiliations.delete_all
        row[4].split(',').each do |aff| @person.affiliations.where(name:aff.titleize).first_or_create end
        @person.locations.delete_all
        row[1].split(',').each do |loc| @person.locations.where(name:loc.titleize).first_or_create end
      end
      # Return Result
      " #{first_name.titleize + last_name.titleize} - #{@person.errors.present? ? "ERROR: #{@person.errors.full_messages}" : 'Success'}"
    else
      # Affiliation not Found
      " #{first_name.titleize + last_name.titleize} - ERROR: Affiliation not Fount"
    end
  end

  def self.get_gender(gender)
    original = gender.underscore.first
    case original
    when 'm'
      'Male'
    when 'f'
      'Female'
    else
      'Other'
    end
  end

end
