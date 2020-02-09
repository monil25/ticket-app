import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/screens/home/home.dart';
import 'package:provider/provider.dart';
//import 'package:coffee_shop/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
