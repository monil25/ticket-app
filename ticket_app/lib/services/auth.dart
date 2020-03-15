import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/services/database.dart';

class AuthService {
  final CollectionReference ticketCollection =
      Firestore.instance.collection('ticket');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser currentUser;
  //create user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      currentUser = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name, String mobileNumber) async {
    print("Registeration was called");
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //Checking of thisis not done now.
      //user.sendEmailVerification();
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(name, mobileNumber, email);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      currentUser = null;
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //bookticket
  Future bookTheTicket(String source, String dest, String classType,
      String journeyType, String durationType, int duration) async {
    //currently ticket valid for same day
    var now = new DateTime.now();
    var lastValid;
    if (durationType.compareTo('day') == 0) {
      lastValid = now.add(new Duration(days: 1));
    } else {
      lastValid = new DateTime(now.year, now.month + duration, now.day);
    }
    String lastValidDate = dateToString(lastValid);
    String date = dateToString(now);
    String time = now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString();
    return await ticketCollection.add({
      'passangerId': currentUser.uid,
      'source': source,
      'destination': dest,
      'bookDate': date,
      'bookTime': time,
      'classType': classType,
      'journeytype': journeyType,
      'lastValidDate': lastValidDate,
    });
  }

  String dateToString(dynamic date) {
    return (date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString());
  }
}
