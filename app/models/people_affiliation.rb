class PersonAffiliation < ActiveRecord::Base

  belongs_to :person
  belongs_to :affiliation

end
