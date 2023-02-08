class Person < ActiveRecord::Base

  has_and_belongs_to_many :locations
  has_and_belongs_to_many :affiliations

  validates_uniqueness_of :first_name, scope: :last_name
  validates_presence_of :first_name, :gender, :species

  # Search Method
  def self.search(search)
    search.present? ? where("first_name LIKE '%#{search}%' OR last_name LIKE '%#{search}%' OR species LIKE '%#{search}%' OR gender LIKE '%#{search}%' OR weapon LIKE '%#{search}%' OR vehicle LIKE '%#{search}%' OR affiliations.name LIKE '%#{search}%' OR locations.name LIKE '%#{search}%'") : all
  end

  # Parse / Import Row
  def self.parse_row(row,count)
    # Check Affiliation / First Name
    if row[0].present? && row[4].present?
      # Build Name
      last_name = row[0].split(' ').size > 1 ? row[0].split(' ').last.titleize : ''
       first_name = row[0].titleize.gsub(last_name,'')
      # Find Existing to Update or Create New
      @person = Person.where(first_name:first_name.rstrip,last_name:last_name).first_or_initialize
      @person.assign_attributes(
        species:row[2],
        gender: Person.get_gender(row[3]),
        weapon:row[5].present? ? row[5] : nil,
        vehicle:row[6].present? ? row[6] : nil
      )
      #
      if @person.save
        # Update Affiliations
        @person.affiliations.delete_all
        row[4].split(',').each do |aff| @person.affiliations << Affiliation.where(name:aff.titleize).first_or_create end
        # Update Locations
        @person.locations.delete_all
        if row[1].present?
          row[1].split(',').each do |loc| @person.locations << Location.where(name:loc.titleize).first_or_create end
        end
        @person.save
      end
      # Return Result
      " #{[first_name,last_name].join(' ')} - #{@person.errors.present? ? "<span style='color:red'> ERROR: #{@person.errors.full_messages} </span>" : 'Success'}"
    else
      # Affiliation / Name not Found
      "<span style='color:red'>ROW #{count.to_i} ERROR: Name or Affiliation not Found</span>"
    end
  end

  # Data Normalizer (Example)
  def self.get_gender(gender)
    original = gender.try(:underscore).try(:first)
    case original
    when 'm'
      'Male'
    when 'f'
      'Female'
    when 'o'
      'Other'
    else
      nil
    end
  end

end
