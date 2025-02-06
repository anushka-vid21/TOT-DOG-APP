TOT APP is a Flutter application that integrates with the FreeTestAPI for Dogs to display and manage information about different dog breeds. The app allows users to browse dog details, search for dogs by breed or name, and save their favorite dogs into a local database.

Features
Dog List Screen: Fetches and displays a list of all dogs with their breed, name, and images.
Dog Detail Screen: Displays detailed information about each dog, including breed group and description.
Search Functionality: Allows users to search for dogs by name or breed.
Save Feature: Lets users save their favorite dogs into a local database and view the saved list.
Local Database: Stores saved dog information in SQLite or Hive for easy access.
UI/UX: A clean, intuitive user interface with smooth navigation and loading indicators.
In the Saved Dogs Screen, the app uses a Dismissible widget to enable swipe-to-delete functionality. When a user swipes a dog entry, a "Delete" button appears, and upon clicking it, the dog is removed from the local database.


Objective
To develop a Flutter app that:

Fetches data from the Dog API.
Displays dog breeds and images.
Allows users to view detailed information, search for dogs, and save their favorite dogs to a local database.

Tech Stack
Frontend: Flutter (Dart)
API: FreeTestAPI for Dogs
Local Database: SQLite or Hive
State Management: Provider or Riverpod (optional, depending on your state management choice)


Screens
Home Screen: Displays a list of all dogs with their name, breed, and image.
Dog Detail Screen: Shows detailed information about a selected dog.
Search Screen: Allows users to search for dogs by breed or name.
Saved Dogs Screen: Displays a list of saved dogs from the local database, allowing users to remove saved dogs.

Installation and Setup
Prerequisites
Flutter: Ensure that you have Flutter SDK installed on your machine.
Dart: Flutter comes with Dart, so you don’t need to install Dart separately.
Android Studio/VSCode: Set up either Android Studio or Visual Studio Code for Flutter development.


