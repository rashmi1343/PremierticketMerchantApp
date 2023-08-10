import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../repository/PtkmerchantRepository.dart';
import '../../../event_details_bloc/event_details_bloc.dart';
import '../../../models/eventsDetailResponse.dart';
import 'SelectNumOfTickets.dart';

enum TicketType {
  Book_Now("1"),
  Sold_Out("3"),
  Booking_Closed("4");

  const TicketType(this.value);
  final String value;
}

class SeatingEventWidget extends StatefulWidget {
  EventsDetailResponse eventDetaillist;
  SeatingEventWidget({required this.eventDetaillist});

  @override
  _SeatingEventWidgetState createState() => _SeatingEventWidgetState();
}

class _SeatingEventWidgetState extends State<SeatingEventWidget> {
  late EventDetailsBloc eventDetailsBloc;
  bool _searchBoolean = false;

  bool _isBookNowBtnShow = true;
  bool isMultipleSeatingEvent = false;

  final _tileKeys = [];
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  bool checkIsMultipleSeatingEvent(int index) {
    if (widget.eventDetaillist.result?.ticketInformation[index].blockgroupdata
        .isNotEmpty) {
      isMultipleSeatingEvent = true;
      print('Multiple Event : $isMultipleSeatingEvent');
      return isMultipleSeatingEvent; // Seating Event
    }
    print('Multiple Event : $isMultipleSeatingEvent');
    return isMultipleSeatingEvent; // Non-Seating Event- false
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: Column(children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              widget.eventDetaillist.result?.ticketInformation?.length ?? 0,
          itemBuilder: (context, index) {
            checkIsMultipleSeatingEvent(index);
            return isMultipleSeatingEvent
                ? _expandableLayoutForMultipleSeating(
                    widget.eventDetaillist, index)
                : ListTile(
                    title: Text(
                      widget.eventDetaillist.result?.ticketInformation[index]
                              .ticketPrice ??
                          "",
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MuliRegular',
                        color: Color(0xff313131),
                      ),
                    ),
                    subtitle: Text(
                      widget.eventDetaillist.result?.ticketInformation?[index]
                              .ticketPrice ??
                          "",
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'MuliRegular',
                        color: Color(0xff313131),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 135,
                      //height: 50,
                      child: Center(
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 8, 195, 8))),
                            onPressed: null,
                            child: const Text(
                              "Book Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
            );
          },
        ),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }

  Widget _expandableLayoutForMultipleSeating(
      EventsDetailResponse eventDetaillist, int mainindex) {
    final tileKey = GlobalKey();
    _tileKeys.add(tileKey);

    print(widget.eventDetaillist.result?.ticketInformation?[mainindex]
        .blockgroupdata.length);
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 10),
      key: tileKey,
      title: ListTile(
        title: Text(
          "${widget.eventDetaillist.result?.ticketInformation[mainindex].blockdetail ?? ""} ${widget.eventDetaillist.result?.ticketInformation[mainindex].blockdesc ?? ""}",
          style: const TextStyle(
            height: 1.2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'MuliRegular',
            color: Color(0xff313131),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        //height: 50,
        child: Center(
          child: Container(
            height: 45,
            width: double.infinity,
            //margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffed3f65))),
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Select Seats',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.eventDetaillist.result
                  ?.ticketInformation?[mainindex].blockgroupdata.length ??
              0,
          itemBuilder: (context, childindex) {
            return showChildDataOfExpandibleList(widget.eventDetaillist.result
                ?.ticketInformation?[mainindex].blockgroupdata[childindex]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
            );
          },
        ),
      ],
      onExpansionChanged: (value) {
        // If tile is expanding, then collapse the already expanded tile.
        if (value) {
          if (mainindex != _selectedIndex) {
            _tileKeys[_selectedIndex].currentState!.closeExpansion();
          }
          _selectedIndex = mainindex;
        }
      },
    );
  }

  Widget showChildDataOfExpandibleList(Blockgroupdatum e) {
    // print(e.ticketName);
    return ListTile(
      title: Text(
        e.ticketName ?? "",
        style: const TextStyle(
          height: 1.2,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'MuliRegular',
          color: Color(0xff313131),
        ),
      ),
      subtitle: Text(
        e.ticketPrice ?? "",
        style: const TextStyle(
          height: 1.2,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'MuliRegular',
          color: Color(0xff313131),
        ),
      ),
      trailing: SizedBox(
        width: 135,
        //height: 50,
        child: Center(
          child: Container(
            height: 40,
            width: double.infinity,
            //margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: (e.ticketStatus == TicketType.Book_Now.value)
                    ? MaterialStateProperty.all(const Color(0xff00a400))
                    : (e.ticketStatus == TicketType.Sold_Out.value)
                        ? MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 42, 42))
                        : MaterialStateProperty.all(
                            Color.fromARGB(255, 185, 185, 185)),
              ),
              onPressed: () {
                (e.ticketStatus == TicketType.Book_Now.value)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectNumOfTickets(
                              eventDetaillist: widget.eventDetaillist,
                              ticketInfo: e,
                            )))
                    : null;
              },
              child: Text(
                e.ticketStatusName?.enumValue ??
                    "", // Getting enum value name from eventDetailsResponse
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: e.ticketStatus == TicketType.Booking_Closed.value
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension PrettyEnum on Object {
  String get enumValue =>
      toString().split('.').last.replaceAll("_", " "); // BOOK_NOW => BOOK NOW
}
