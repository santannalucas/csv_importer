class PersonTest < ActiveSupport::TestCase

  # Example of Validation Tests
  test "should not save person without name" do
    person = Person.new(last_name:'Untitled')
    assert_not person.save, "Saved the my model without a name"
  end

  test "should not save person with duplicate name and last_name" do
    Person.create(first_name: "Din", last_name: 'Djarin', species: 'Human', gender: 'Male', weapon: 'Amban Sniper Rifle', vehicle: 'Razor Crest')
    person = Person.new(first_name: "Din", last_name: 'Djarin', species: 'Human', gender: 'Male')
    assert_not person.save, "Failed to save person with duplicated first name and last name"
  end

  test "should not save person without gender" do
    person = Person.new(first_name: "Din", last_name: 'Djarin', species: 'Human')
    assert_not  person.save, "Failed to save person model without gender"
  end

  test "should not save person without species" do
    person = Person.new(first_name: "Din", last_name: 'Djarin', gender: 'Male')
    assert_not  person.save, "Failed to save person model without species"
  end

  # Parser/Row Importer Test
  test "parser should update person if it already exist" do
    Person.create(first_name: "Din", last_name: 'Djarin', species: 'Human', gender: 'Male', weapon: 'Amban Sniper Rifle', vehicle: 'Razor Crest')
    Person.parse_row(['Din Djarin','Mandalore','Human','Male','Mandalorians Guild','Amban Sniper Rifle','Speedster'],1)
    people = Person.where(first_name:'Din',last_name: 'Djarin')
    assert_equal true, people.count == 1
  end

  # Search Test
  test "search should return results" do
    Person.create(first_name: "Din", last_name: 'Djarin', species: 'Ugnaught', gender: 'Male', weapon: 'Amban Sniper Rifle', vehicle: 'Razor Crest')
    Person.create(first_name: "Kuiil", species: 'Human', gender: 'Male', vehicle: 'Blurrg')
    people = Person.left_joins(:affiliations,:locations).search("Din")
    assert_equal 1, people.count, 'Search returns result'
  end

end