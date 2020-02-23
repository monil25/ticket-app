import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app/models/brew.dart';
import 'package:ticket_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  // final CollectionReference brewCollection =
  //     Firestore.instance.collection('brews');

  final CollectionReference passengerCollection =
      Firestore.instance.collection('passenger');

  // final CollectionReference ticketCollection =
  //     Firestore.instance.collection('ticket');

  Future<void> updateUserData(
      String name, String mobileNumber, String email) async {
    return await passengerCollection.document(uid).setData({
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
    });
  }

  // Future<void> bookTicket(String source, String dest) async {
  //   //currently ticket valid for same day
  //   var now = new DateTime.now();
  //   return await ticketCollection.document(uid).setData({
  //     'passangerId': uid,
  //     'source': source,
  //     'destination': dest,
  //     'bookTimeStamp': now,
  //   });
  // }
  // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     //print(doc.data);
  //     return Brew(
  //         name: doc.data['name'] ?? '',
  //         strength: doc.data['strength'] ?? 0,
  //         sugars: doc.data['sugars'] ?? '0');
  //   }).toList();
  // }

  // user data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot.data['name'],
  //       sugars: snapshot.data['sugars'],
  //       strength: snapshot.data['strength']);
  // }

  // get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // get user doc stream
  // Stream<UserData> get userData {
  //   return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  // }
}
