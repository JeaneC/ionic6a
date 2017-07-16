Mobile App Documentation Will Go Here

This is the ionic6 mobile App for iOS

This is now open source. But because of the auth feature required, you won't be able to read online files. I will upload images of the application in us, and I will also upload the json equivalent of my database (with changed values) as an example.

There is a guest account login (currently disabled):

Username: guest@guest.com

Pass: guestpass

The web version of this app is going to be on jisy.me/ionic6/login.html

The App Is Currently Fully Functional as of V 1.0.

Features Include
- Full incorporation of Firebase. All data displayed is online. If any data is changed, the app will update it immediately
- Ability to navigate between 3 site locations
- Ability to view past history logs
- Ability to check the attendance in real time (Meaning if the attendance is updated else where, it will update in the app as well)
- Ability to do a "Head Check", which is a convenient way of checking to see if all students are present at a certain location

Bugs/Needs Fixing
- Sometimes certain pieces of data won't show. For instance when navigating initially between Students and History, sometimes the logs will not show, sometimes the students won't show.
    - This error is most likely due to time. Firebase does synchronize in real time, but users who immediately select an option might barely beat Firebase's server time.
    - The simple fix to this is to just go back to the option after selected another option
    - Or pressing back, and then coming back

Features Wishlist
- Ability to create students
- Storing images online, and then acessing them (Student Profile Pictures)


V 1.5
Features Added
- The device now properly displays who authorized/confirmed each form. Handy for tracking which instructor logs a person in or out.
- Updated the UI for history logs

Features Wishlist
- Ability to create students (still)
- Storing images(still)

V 1.51
- Open-Sourced

Incoming Features For Next Version, V 2.0
- Ability to create students
- Ability to modify logs
- Ability to edit student details
- (Maybe) A UI Update
