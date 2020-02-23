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
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      currentUser = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    print("SignIn was called");
    try {
      print(_auth);
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
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
      print(user);
      user.sendEmailVerification();
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(name, mobileNumber, email);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
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
  Future<void> bookTicket(String source, String dest) async {
    //currently ticket valid for same day
    var now = new DateTime.now();
    String date = now.day.toString() +
        "/" +
        now.month.toString() +
        "/" +
        now.year.toString();
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
    });
  }
}
