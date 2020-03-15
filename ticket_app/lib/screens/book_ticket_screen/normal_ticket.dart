import 'package:flutter/material.dart';
import 'package:ticket_app/services/auth.dart';
import 'package:ticket_app/shared/constants.dart';
import 'package:ticket_app/shared/loading.dart';

class NormalTicket extends StatefulWidget {
  final List<String> stations;
  NormalTicket({this.stations});
  @override
  _NormalTicketState createState() => _NormalTicketState();
}

class _NormalTicketState extends State<NormalTicket> {
  static List<String> journeyTypes = ['Single Journey', 'Return Journey'];
  String _journeyType = journeyTypes[0];
  void _onchangedJourneyType(String value) {
    setState(() {
      _journeyType = value;
    });
  }

  static List<String> classTypes = [
    'Second Class : II',
    'First Class : I',
    'AC Coach'
  ];
  String _classType = classTypes[0];
  void _onchangedClassType(String value) {
    setState(() {
      _classType = value;
    });
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Book Your Ticket'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Source : ' + widget.stations[0],
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Destination : ' + widget.stations[1],
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Journey Type'),
                        value: _journeyType,
                        items: journeyTypes.map((String value) {
                          return new DropdownMenuItem(
                              value: value, child: new Text(value));
                        }).toList(),
                        onChanged: (String value) {
                          _onchangedJourneyType(value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        value: _classType,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Class Type'),
                        items: classTypes.map((String value) {
                          return new DropdownMenuItem(
                              value: value, child: new Text(value));
                        }).toList(),
                        onChanged: (String value) {
                          _onchangedClassType(value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Book Ticket',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.bookTheTicket(
                                  widget.stations[0],
                                  widget.stations[1],
                                  _classType,
                                  _journeyType,
                                  "day",
                                  1);
                              print(result);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Some Error Ocurred while Registeration';
                                });
                              } else {
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
