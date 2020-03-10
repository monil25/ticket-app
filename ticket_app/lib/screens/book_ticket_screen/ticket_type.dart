import 'package:flutter/material.dart';
import 'package:ticket_app/screens/book_ticket_screen/normal_ticket.dart';
import 'package:ticket_app/screens/book_ticket_screen/season_ticket.dart';

class TicketType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Select Type of Ticket'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
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
                  ButtonTheme(
                    minWidth: 300,
                    height: 60,
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NormalTicket(),
                                fullscreenDialog: true));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.check_circle),
                      label: Text(
                        "Normal Ticket",
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
                                builder: (context) => SeasonTicket(),
                                fullscreenDialog: true));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      icon: Icon(Icons.assignment),
                      label: Text(
                        "Season Ticket",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
