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
    name: row[0]
  )
end


CSV.foreach("db/budgets.csv", headers: true) do |row|

 Budget.create(
    total: row[0].to_i,
    trip_id: row[1]
  )
end

trips_wardrobes = {10 => (1..74).to_a, 18 => (75..214).to_a } 

trips_wardrobes.each do |trips, wardrobes|
  wardrobe = Wardrobe.find(trips)
  wardrobes.each do |wardrobe_item|
    wardrobe.trips << Trip.find(wardrobe_item)
  end
end
