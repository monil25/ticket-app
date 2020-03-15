import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference passengerCollection =
      Firestore.instance.collection('passenger');

  Future<void> updateUserData(
      String name, String mobileNumber, String email) async {
    return await passengerCollection.document(uid).setData({
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
    });
  }
}
