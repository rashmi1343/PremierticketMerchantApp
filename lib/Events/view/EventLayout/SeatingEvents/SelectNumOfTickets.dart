import 'package:flutter/material.dart';

import '../../../../EventSeatLayout/EventSeatLayout.dart';
import '../../../models/eventsDetailResponse.dart';

class SelectNumOfTickets extends StatefulWidget {
  EventsDetailResponse eventDetaillist;
  Blockgroupdatum ticketInfo;

  SelectNumOfTickets(
      {super.key, required this.eventDetaillist, required this.ticketInfo});
  @override
  _SelectNumOfTicketsStateWidget createState() =>
      _SelectNumOfTicketsStateWidget();
}

class _SelectNumOfTicketsStateWidget extends State<SelectNumOfTickets> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "HOW MANY TICKETS?",
                    style: TextStyle(
                      fontFamily: "MuliRegular",
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff243444),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please select number of tickets you want to book",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "MuliRegular",
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff243444),
                    ),
                  ),
                  Container(
                    // height: double.infinity,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 55,
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 5 : 8,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              _selectedIndex = index;
                              print('Selected Tickets : ${_selectedIndex + 1}');
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // height: 108,
                            // width: 50,
                            constraints: const BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 10, top: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                  width: 0.5, color: Color(0xffB4B4B4)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffB4B4B4),
                                  blurRadius: 0.3,
                                ),
                              ],
                              color: _selectedIndex == index
                                  ? Color.fromARGB(255, 233, 84, 153)
                                  : const Color(0xffffffff),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                '${index + 1}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedIndex == index
                                        ? const Color(0xffffffff)
                                        : Color(0xff111111),
                                    fontFamily: 'MuliRegular'),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You are allowed to book a maximum of 20 ticket(s).",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "MuliRegular",
                      fontSize: 17,
                      color: Color(0xff243444),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff00a400))),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => EventSeatLayout()));
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            fontFamily: "MuliRegular",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontFamily: "MuliRegular",
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
