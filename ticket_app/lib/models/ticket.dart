import 'package:flutter/material.dart';

class Ticket {
  final String source;
  final String ticketId;
  final String userId;
  final int classType; //1st 2nd
  final String destination;
  final int cost;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay bookingTime;

  Ticket(
      {this.source,
      this.ticketId,
      this.userId,
      this.classType,
      this.destination,
      this.cost,
      this.startDate,
      this.endDate,
      this.bookingTime});
}
