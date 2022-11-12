# Flutter CRUD Firebase

This project is focused to expose how to create a Flutter App with a Login & Sign Up functions for admin users. Also create, read, update and delete functions for items in a database. This project uses Firabase and work with Collections instead of Tables, Documents intead of Rows and Json attributes for fields. 

## Getting Started

#### Login and Sign Up functions:

The app was created as basic Flutter aplication the main.dart file only requires modification for initialize Firebase. main.dart file use the views_controller.dart file to initialize the current user in the app and shows pages depending of the login. The sign_up_page.dart and login_page.dart files create and give access to the Firebase Database with Email and Password fields.

In the Firebase page the Authentication options has to be configured, add the google-services.json file and the dependencies to the pubspec.yaml file.

#### CRUD functions

To create a new document in the Firebase collection is necesary use a Form widget that capture and validate the data, to do that the form fields uses controllers, regular expressions and a form global key. In the item_view.dart are implemented the update and delete functions. The home_page.dart list all the users and provied filters.


