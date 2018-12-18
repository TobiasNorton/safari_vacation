require 'pg'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "safari_vacation"
)

class SeenAnimal < ActiveRecord::Base
end

def json_print data
  puts JSON.pretty_generate(data.as_json)
end

json_print(SeenAnimal.all)



tigers = SeenAnimal.where(species: "Tigers")
tigers.update(count_of_times_seen: 28, location_of_last_seen: "Grasslands")
json_print(tigers)

json_print(SeenAnimal.where(location_of_last_seen: "Jungle"))

SeenAnimal.where(location_of_last_seen: "Desert").delete_all


def total_times_seen
  sightings = []
  seen_animals = SeenAnimal.all
  seen_animals.each {|s| sightings.push(s.count_of_times_seen)}
  puts sightings.sum
end

total_times_seen

def lions_tigers_bears_seen
  sightings = []
  SeenAnimal.all.each do |animal|
    if (animal.species == "Lions" ||
      animal.species == "Tigers" ||
      animal.species == "Bears")
      sightings.push(animal.count_of_times_seen)
    end
  end
  puts sightings.sum
end

lions_tigers_bears_seen