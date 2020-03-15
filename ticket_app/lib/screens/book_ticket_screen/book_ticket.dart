import 'package:flutter/material.dart';
import 'package:ticket_app/shared/constants.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class BookTicket extends StatefulWidget {
  @override
  _BookTicketState createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  AutoCompleteTextField searchTextField1;
  AutoCompleteTextField searchTextField2;
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  List<String> stations = [];
  String sourceStation = '';
  String destStation = '';
  // stations.addAll(westernStns);

  void getStations() {
    stations.addAll(centralStns);
    stations.addAll(westernStns);
    stations.remove('Dadar'); //As repeated two times in list
  }

  void initState() {
    getStations();
    super.initState();
  }

  Widget _buildRow(String station) {
    return ListTile(
      title: Text(
        station,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  void _showDialog(String error) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(error),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Stations"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchTextField1 = AutoCompleteTextField<String>(
            key: key1,
            clearOnSubmit: false,
            suggestions: stations,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
              hintText: "Source Station",
              hintStyle: TextStyle(color: Colors.black),
            ),
            itemFilter: (item, query) {
              return item.toLowerCase().startsWith(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.compareTo(b);
            },
            itemSubmitted: (item) {
              setState(() {
                if (item.compareTo(destStation) != 0) {
                  print('source $item');
                  searchTextField1.textField.controller.text = item;
                  sourceStation = item;
                } else {
                  _showDialog("Source and Destination cannot be same");
                  sourceStation = "";
                  searchTextField1.textField.controller.text = "";
                }
              });
            },
            itemBuilder: (context, item) {
              // ui for the autocompelete row
              return _buildRow(item);
            },
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          searchTextField2 = AutoCompleteTextField<String>(
            key: key2,
            clearOnSubmit: false,
            suggestions: stations,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
              hintText: "Destination Station",
              hintStyle: TextStyle(color: Colors.black),
            ),
            itemFilter: (item, query) {
              return item.toLowerCase().contains(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.compareTo(b);
            },
            itemSubmitted: (item) {
              setState(() {
                if (item.compareTo(sourceStation) != 0) {
                  destStation = item;
                  print('destination $item');
                  searchTextField2.textField.controller.text = item;
                } else {
                  _showDialog("Source and Destination cannot be same");
                  destStation = "";
                  searchTextField2.textField.controller.text = "";
                }
              });
            },
            itemBuilder: (context, item) {
              // ui for the autocompelete row
              return _buildRow(item);
            },
          ),
          SizedBox(height: 20.0),
          RaisedButton(
              color: Colors.blue[400],
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (sourceStation.length == 0) {
                  _showDialog("Please Select Source");
                } else if (destStation.length == 0) {
                  _showDialog("Please Select Destination");
                } else {
                  if (!stations.contains(sourceStation)) {
                    _showDialog("Source Station not found");
                  } else if (!stations.contains(destStation)) {
                    _showDialog("Destination Station not found");
                  } else {
                    // await _auth.bookTicket(sourceStation, destStation);
                    print("Stations Selected");
                    List<String> stations = [];
                    stations.add(sourceStation);
                    stations.add(destStation);
                    Navigator.pop(context, stations);
                  }
                }
              }),
        ],
      ),
    );
  }
}
