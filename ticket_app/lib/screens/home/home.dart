import 'package:flutter/material.dart';
import 'package:ticket_app/screens/book_ticket_screen/book_ticket.dart';
import 'package:ticket_app/screens/book_ticket_screen/ticket_type.dart';
import 'package:ticket_app/screens/ticket_check/enter_code.dart';
import 'package:ticket_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('M-Ticket'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: new Center(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ticketCheck.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: ListView(
                children: <Widget>[
                  // OutlineButton(
                  //     onPressed: () => null,
                  //     child: Stack(
                  //         children: <Widget>[
                  //             Align(
                  //                 alignment: Alignment.centerLeft,
                  //                 child: Icon(Icons.access_alarm)
                  //             ),
                  //             Align(
                  //                 alignment: Alignment.center,
                  //                 child: Text(
                  //                     "Testing",
                  //                     textAlign: TextAlign.center,
                  //                 )
                  //             )
                  //         ],
                  //     ),
                  //     highlightedBorderColor: Colors.orange,
                  //     color: Colors.green,
                  //     borderSide: new BorderSide(color: Colors.green),
                  //     shape: new RoundedRectangleBorder(
                  //         borderRadius: new BorderRadius.circular(5.0)
                  //     )
                  // ),
                  ButtonTheme(
                    minWidth: 300,
                    height: 60,
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PinCodeVerificationScreen(),
                                fullscreenDialog: true));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.check_circle),
                      label: Text(
                        "Get Ticket Checked",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ButtonTheme(
                    minWidth: 300,
                    height: 60,
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketType(),
                                fullscreenDialog: true));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.assignment),
                      label: Text(
                        "Book Ticket",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ButtonTheme(
                    minWidth: 300,
                    height: 60,
                    child: RaisedButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.assessment),
                      label: Text(
                        "Booking History",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ButtonTheme(
                    minWidth: 300,
                    height: 60,
                    child: RaisedButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.account_box),
                      label: Text(
                        "Your Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
