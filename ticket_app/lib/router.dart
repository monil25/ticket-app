import 'package:flutter/material.dart';
import 'package:ticket_app/screens/book_ticket_screen/ticket_type.dart';
import 'package:ticket_app/screens/home/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/bookTicket':
        return MaterialPageRoute(builder: (_) => TicketType());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
