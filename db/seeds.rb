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
