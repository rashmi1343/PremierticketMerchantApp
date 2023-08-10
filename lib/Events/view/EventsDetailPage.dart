import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../repository/PtkmerchantRepository.dart';
import '../event_details_bloc/event_details_bloc.dart';
import '../models/eventsDetailResponse.dart';
import 'EventLayout/NonSeatingEventsWidget.dart';
import 'EventLayout/SeatingEvents/SeatingEventWidget.dart';
import 'Subscribe&ContactOrg.dart';

class EventsDetailPage extends StatefulWidget {
  final PtkmerchantRepository eventDetailsRepo;
  String eventid;

  EventsDetailPage({required this.eventDetailsRepo, required this.eventid})
      : assert(eventDetailsRepo != null),
        super();

  @override
  _EventsDetailPageState createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  late EventDetailsBloc eventDetailsBloc;
  bool _searchBoolean = false;

  bool isSeatingEvent = false;

  PtkmerchantRepository get _eventDetailsRepository => widget.eventDetailsRepo;

  @override
  void initState() {
    eventDetailsBloc = EventDetailsBloc(
        ptkrepository: _eventDetailsRepository,
        eventid: widget.eventid.toString());
    eventDetailsBloc.add(FetchDetailEvents());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xfff9fdfe),
        elevation: 0,
        title: Image.asset(
          'assets/images/logoptk.png',
          width: 110,
          height: 75,
        ),
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Image.asset(
                "assets/images/back.png",
                color: const Color(0xff000000),
                height: 21,
                width: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<EventDetailsBloc, EventDetailsState>(
        bloc: eventDetailsBloc,
        builder: (
          BuildContext context,
          EventDetailsState state,
        ) {
          if (state is EventDetailsInitial) {
            print("initial state");
            return buildLoading();
          } else if (state is EventDetailsLoaded) {
            print("loaded state");
            print("eventDetaillist:${state.eventDetailsList}");
            return _buildListView(state.eventDetailsList);
          } else if (state is EventDetailsErrorState) {
            print("error state");
            return buildErrorUi(state.message);
          } else {
            print("loading progress state");
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  bool checkEventType(EventsDetailResponse eventDetaillist) {
    if (eventDetaillist.result?.isSeatBooking == "1") {
      isSeatingEvent = true;
      return isSeatingEvent; // Seating Event
    }
    return isSeatingEvent; // Non-Seating Event- false
  }

  Widget _buildListView(EventsDetailResponse eventDetaillist) {
    checkEventType(eventDetaillist);
    print("eventDetaillist:$eventDetaillist");
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        // ConstrainedBox(
        //   constraints:
        //       BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 5.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),

              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          eventDetaillist.result!.eventTitle.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MuliRegular',
                              color: Color(0xffda2727)),

                          // softWrap: true,
                          //  maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        "assets/images/calendar-solid.svg",
                        width: 18,
                        height: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          eventDetaillist.result!.eventDate.toString(),
                          style: const TextStyle(
                              height: 1.2,
                              fontSize: 15,
                              fontFamily: 'MuliRegular',
                              color: Color(0xff313131)),
                          //  softWrap: true,
                          //  maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.local_activity,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${eventDetaillist.result!.venuename.toString()}, ${eventDetaillist.result!.venueAddress.toString()}, ${eventDetaillist.result!.venuepostCode.toString()}, ${eventDetaillist.result!.venueState.toString()}, ${eventDetaillist.result!.venueCountry.toString()}",
                          style: const TextStyle(
                              height: 1.2,
                              fontSize: 15,
                              fontFamily: 'MuliRegular',
                              color: Color(0xff313131)),
                          //  softWrap: true,

                          // maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              // ),
            ),
            // Expanded(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 0, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 5.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: isSeatingEvent
                  ? SeatingEventWidget(
                      eventDetaillist: eventDetaillist,
                    )
                  : NonSeatingEventsWidget(
                      eventDetaillist: eventDetaillist,
                      eventDetailsRepo: widget.eventDetailsRepo,
                    ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 5.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),

              child: ExpansionTile(
                title: const Text(
                  'About the Event',
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MuliRegular',
                      color: Color(0xff0738a5)),
                ),
                children: <Widget>[
                  // Expanded(
                  //   child:
                  Html(
                    data: eventDetaillist.result!.eventDetail.toString(),
                    style: {
                      "body": Style(
                        fontSize: const FontSize(16.0),
                        fontWeight: FontWeight.normal,
                        fontFamily: 'MuliRegular',
                      ),
                      'h1': Style(
                        color: Colors.red,
                        fontFamily: 'MuliRegular',
                      ),
                      'p': Style(
                        color: Colors.black87,
                        fontSize: FontSize.xSmall,
                        fontFamily: 'MuliRegular',
                      ),
                      'ul': Style(
                          fontFamily: 'MuliRegular',
                          margin: const EdgeInsets.symmetric(vertical: 20))
                    },
                  ),
                  // ),
                ],
              ),
              // ],
            ),
            // ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffed3f65))),
                // onPressed: (!validationProvider.isValid)?null:validationProvider.sumbitData ,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SubscribeAndContactOrg(
                            isFromSubscribeNow: true,
                          )));
                },
                child: const Text(
                  "Subscribe Now",
                  style: TextStyle(
                      fontFamily: 'MuliRegular',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff0738a5))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SubscribeAndContactOrg(
                            isFromSubscribeNow: false,
                          )));
                },
                child: const Text(
                  "Contact Organiser",
                  style: TextStyle(
                      fontFamily: 'MuliRegular',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
