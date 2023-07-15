import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String phone;

  User({required this.name, required this.email, required this.phone});
}

class DatabaseService {
  static void registerUser(User user) {
    // Store the user's information in a Firestore collection
    FirebaseFirestore.instance.collection('users').add({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
    });
  }
}