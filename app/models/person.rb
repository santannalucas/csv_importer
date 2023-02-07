class Person < ActiveRecord::Base

  has_and_belongs_to_many :locations
  has_and_belongs_to_many :affiliations

  validates_uniqueness_of :first_name, scope: :last_name
  validates_presence_of :first_name

  def self.search(search)
    search.present? ? where("first_name LIKE '#{search} ' OR last_name LIKE '#{search}'") : all
  end
end
