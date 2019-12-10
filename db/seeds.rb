# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Room.delete_all
# Ensuring all of the three rooms specified on the studios' page are in the database
room_one = Room.create(room_id: 1, description: "DJ Studio", price: 15)
room_two = Room.create(room_id: 2, description: "Band Recording Studio", price: 20)
room_three = Room.create(room_id: 3, description: "Production Studio", price: 45)

# Creating an initial admin account, as not possible to make one when regularly signing up, but can be done
# on the admin page
admin = User.create(email: "adminlogin@admin.com", password: "admin", is_admin: true)