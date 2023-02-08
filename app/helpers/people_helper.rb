module PeopleHelper

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # Sort Column
  def sort_column
    acceptable_cols = %w(
      people.first_name
      people.last_name
      locations.name
      people.species
      people.gender
      affiliations.name
      people.weapon
      people.vehicle
      )
    acceptable_cols.include?(params[:sort]) ? params[:sort] : "people.first_name"
  end

  # Sort Method
  def sort(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    link_to title, {:sort => column, :direction => direction, :search => params[:search]}, {:title => "Sort"}
  end

end
