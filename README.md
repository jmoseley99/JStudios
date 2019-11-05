#README

1. Find a template to use (Y)
2. Implement a navbar to go between pages (Y)
3. Implement my models written on previous readmem(Y)
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


 <table>
   <thead>
     <tr>
       <th>Roomid</th>
       <th>Description</th>
       <th colspan="3"></th>
     </tr>
   </thead>
 
   <tbody>
     <% @rooms.each do |room| %>
       <tr>
         <td><%= room.RoomID %></td>
         <td><%= room.Description %></td>
         <td><%= link_to 'Show', room %></td>
         <td><%= link_to 'Edit', edit_room_path(room) %></td>
         <td><%= link_to 'Destroy', room, method: :delete, data: { confirm: 'Are you sure?' } %></td>
       </tr>
     <% end %>
   </tbody>
 </table>
 
 <br>
 
 <%= link_to 'New Room', new_room_path %>