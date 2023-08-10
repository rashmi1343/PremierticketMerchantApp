import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingTicket extends StatefulWidget {
  BookingTicketState createState() => BookingTicketState();
}

class BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const Text(
              "How Many Tickets ?",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: "GraphikBold"),
            ),
            const Text(
              "Please select number of tickets you want to book",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: "GraphikRegular"),
            ),
            const Text(
              "You are allowed to book a maximum of 3 ticket(s).",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: "GraphikRegular"),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}
