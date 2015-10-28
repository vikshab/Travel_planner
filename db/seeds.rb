require 'csv'

CSV.foreach("db/users.csv", headers: true) do |row|

  User.create(
    user_name: row[0],
    email: row[1],
    password: row[2],
    password_confirmation: row[3],
    phone: row[4]
  )
end

CSV.foreach("db/trips.csv", headers: true) do |row|

  Trip.create(
    destination: row[0],
    start_date: row[1],
    end_date: row[2],
    image_url: row[3],
    user_id: row[4]
  )
end

CSV.foreach("db/tasks.csv", headers: true) do |row|

  Task.create(
    title: row[0],
    description: row[1],
    date: row[2],
    trip_id: row[3]
  )
end

CSV.foreach("db/wardrobes.csv", headers: true) do |row|

 Wardrobe.create(
    name: row[0],
    date: row[1]
  )
end


CSV.foreach("db/budgets.csv", headers: true) do |row|

 Budget.create(
    total: row[0].to_i,
    date: row[1],
    trip_id: row[2]
  )
end

trips_wardrobes = {10 => (1..74).to_a, 18 => (75..214).to_a }

trips_wardrobes.each do |t, w|
  trip = Trip.find(t)
  w.each do |item|
    trip.wardrobes << Wardrobe.find(item)
  end
end

# trips_wardrobes.each do |trip, wardrobes|
#   wardrobe = Wardrobe.find(wardrobes)
#   wardrobes.each do |wardrobe_item|
#     wardrobe.trips << Trip.find(wardrobe_item)
#   end
# end
