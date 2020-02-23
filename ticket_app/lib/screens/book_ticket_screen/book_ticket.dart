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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Your Ticket"),
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
                }
              });
            },
            itemBuilder: (context, item) {
              // ui for the autocompelete row
              return _buildRow(item);
            },
          ),
        ],
      ),
    );
  }
}
