#README

1. Find a template to use
2. Implement a navbar to go between pages
3. Implement my models written on previous readme
4. Begin formatting page


User:
UserID: INT
FName: TEXT
SName: TEXT
email: TEXT
mobile: INT

one user -> many bookings

Booking:
BookingID: INT
UserID (Foreign Key): INT
RoomID : INT
Time: TEXT

one booking -> one room

Room:
RoomID: INT
BookingID: INT
Description: TEXT


person must register/sign in to book rooms
user can choose a time to book from a date/time drop down
user is associated with a booking, linked through userID
user can click page to see previous bookings
user can also cancel booking from this page

bookings can only be made on the hour , 1 - 2, 2 - 3, 3 - 4...
any new booking must not clash with another 

checking clash: select bookingID from booking where time = *new booking time*, if there is a booking id, there is a clash 


 