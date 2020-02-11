import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class User1 {
  int id;
  String name;
  String email;

  User1({this.id, this.name, this.email});

  factory User1.fromJson(Map<String, dynamic> parsedJson) {
    return User1(
      id: parsedJson["id"],
      name: parsedJson["name"] as String,
      email: parsedJson["email"] as String,
    );
  }
}

class AutoCompleteDemo extends StatefulWidget {
  AutoCompleteDemo() : super();

  final String title = "AutoComplete Demo";

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<User1>> key = new GlobalKey();
  static List<User1> users = new List<User1>();
  bool loading = true;

  void getUsers() async {
    try {
      final response =
          await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<User1> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<User1>((json) => User1.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(User1 user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.name,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          user.email,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          loading
              ? CircularProgressIndicator()
              : searchTextField = AutoCompleteTextField<User1>(
                  key: key,
                  clearOnSubmit: false,
                  suggestions: users,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    hintText: "Search Name",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  itemFilter: (item, query) {
                    return item.name
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.name.compareTo(b.name);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      searchTextField.textField.controller.text = item.name;
                    });
                  },
                  itemBuilder: (context, item) {
                    // ui for the autocompelete row
                    return row(item);
                  },
                ),
        ],
      ),
    );
  }
}
