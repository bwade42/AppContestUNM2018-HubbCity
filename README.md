# Hubb City App for IOS - Built by Brandon Wade

Hubb City is an ios application built for the manager of "Hubb City", which is a Carpet Cleaning, and Auto Detailing bussiness.  The Owner said the customers, and himself, had issues keep tracking of appointments. This app solves this issue by taking advantage of the Firebase Platform which is Google's mobile platform that helps quickly develop high-quality apps and grow your business. More specifically, I used the Database and Authenication functionailtys to create an app thats able to not keep track of all Hubb City's customers, but it also has the abilty to create schedules or appointments, which include, name, phone number, service, and date of the appointment. The app then places this information in a TableView that customers can view and essentially know when there appointment is at times. The Owner is also able to "Approve" customers appointments.

# In App Navigation - User
  1. Sign up for an account
  2. Log In in with account credentials
  3. Schedule An Appointment
  4. View Appointments - Wait for appointment to be approved by owner, should recieve a phone within 1-2 hours
  
# Outside App Naviagtion  - Firebase
  1. Owner signs into Firebase
  2. Navigate to Database tab
  3. Open up the schedule, calls the potential customer with the phone number they entered to confirm appointment
  4. Owner changes "Pending" to "Approve" in database, the changes should be reflected instantly in the app.

# Resources
 1. Swift
 2. Firebase https://firebase.google.com
 3. Icons https://icons8.com/ios-icons/
 
# Functionality 
1. Database with information on all the users that sign up for the app
   - Users cant have an empty username or password, the fields will highlight in red indicating empty information
   - Users can sign up for an admin account if they know the admin key
2. Log In Capabilities - Authenicated requirement for logging in
   - Users cant have an empty username or password, an alert will pop up saying "Error Loging In"
3. Schedule An Appointment - Users will fill out text fields i.e name, phone, service, and use UIDatePicker that will create
   a schedule, when the user clicks "finished" this schedule will be sent to the Firebase Database
   - Schedule Appointment includes an UIDatePicker
4.View Appointments - Customers/Users will find a view of the scheduled appoints on a Table View. This view inclueds, date,
                      time and serivce
  - Appointment Status: changes dynamic from "Pending" to "Approved" based on interaction with Firebase

# Smaller Functionalitys include:
- Navigation Controller for easy navigation through app.
- Logout button that logs user out their accounts
License

This project is licensed under the MIT License - see the LICENSE.md file for details
