// const String currentId = "LibsDocjUEaPTGdm6ke9yhM9HRV2";

import 'package:firebase_auth/firebase_auth.dart';

// Retrieve the current user's ID and assign it to a variable
String getCurrentUserID() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  if (user != null) {
    return user.uid;
  }
  // If no user is currently signed in, return an empty string or handle the situation accordingly
  return '';
}

// Assign the current user's ID to the 'currentId' variable and get a shorter version
String currentId = getCurrentUserID();
String shortenedId = currentId.substring(0, 24); // Extract the first 8 characters


