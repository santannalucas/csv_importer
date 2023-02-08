class PersonTest < ActiveSupport::TestCase
  test "should not save my model without name" do
    person = Person.new(last_name:'Untitled')
    assert_not person.save, "Saved the my model without a name"
  end

  test "should not save my model with duplicate email" do
    Person.create(first_name: "Din", last_name: 'Djarin')
    person = Person.new(first_name: "Din")
    assert_not person.save, "Saved the my model with a duplicate email"
  end

  test "should save my model with unique email" do
    person = Person.new(name: "John")
    assert person.save, "Failed to save the my model with a unique email"
  end
end