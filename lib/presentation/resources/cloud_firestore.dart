import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> uploadNameAndEmailToDatabase(
      {required String name, required String email}) async {
    String formattedTimestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "name": name,
      "email": email,
      "createdAt": formattedTimestamp,
    });
  }

  Future<Map<String, dynamic>> getNameAndEmail() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        return {
          "name": userData['name'],
          "email": userData['email'],
        };
      } else {
        return {
          "name": '',
          "email": '',
        };
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {
        "name": '',
        "email": '',
      };
    }
  }


}