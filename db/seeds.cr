require "../config/application.cr"

event = Event.new
event.deadline = Time.new(2019, 5, 1, 1, 1, 1)
event.memo = "po"
event.title = "test"
event.save!# Test user for auth

User.create(email: "admin@example.com", password: "password")
