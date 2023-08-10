import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/PtkmerchantRepository.dart';

import '../event_bloc/events_bloc.dart';
import '../models/events_model.dart';
import 'EventsDetailPage.dart';

class EventsPageNew extends StatefulWidget {
  final PtkmerchantRepository eventRepo;
  String accesstoken;
  String accesskey;

  EventsPageNew(
      {required this.eventRepo,
      required this.accesskey,
      required this.accesstoken})
      : assert(eventRepo != null),
        super();

  @override
  State<EventsPageNew> createState() => _EventsPageNewState();
}

class _EventsPageNewState extends State<EventsPageNew> {
  late EventsBloc eventsBloc;
  bool _searchBoolean = false;

  late List<Eventlist> arreventlist;

  PtkmerchantRepository get _eventsRepository => widget.eventRepo;

  @override
  void initState() {
    eventsBloc = EventsBloc(
      ptkrepository: _eventsRepository,
      //accesstoken: widget.accesstoken,
    );
    eventsBloc.add(FetchEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xfff9fdfe),
        elevation: 1,
        title: Image.asset(
          'assets/images/logoptk.png',
          width: 110,
          height: 75,
        ),
        // leading: Builder(
        //   builder: (context) => Container(
        //     margin: const EdgeInsets.only(left: 10),
        //     child: IconButton(
        //       alignment: Alignment.centerLeft,
        //       icon: Image.asset(
        //         "assets/images/back.png",
        //         color: const Color(0xff000000),
        //         height: 21,
        //         width: 24,
        //       ),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        // ),
      ),
      body: BlocBuilder<EventsBloc, EventsState>(
        bloc: eventsBloc,
        builder: (
          BuildContext context,
          EventsState state,
        ) {
          if (state is EventsInitialState) {
            print("initial state");
            return buildLoading();
          } else if (state is EventsLoaded) {
            print("loaded state");
            arreventlist = state.eventsList;
            return _buildListView(state.eventsList);
          } else if (state is EventsErrorState) {
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

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  /*
  Widget _buildPanel(List<Eventlist> eventlist) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          eventlist[index].isExpanded = !isExpanded;
        });
      },
      children:   eventlist.map<ExpansionPanel>((Eventlist item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return  Card(
                margin: EdgeInsets.all(10),
                child:
                SizedBox(
                    height: 200,
                    child:Row(

                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Image.network(
                              item.eventImage.toString(),
                              fit: BoxFit.fitHeight,

                            ),
                          ),
                          Flexible(
                              flex: 3,
                              child:
                              _EventDetails(eventtitle: item.eventTitle, eventdate: item.eventDate, venuedetail: item.venueAddress)
                          )
                        ]
                    )));
          },
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  item.eventdetailResult!.eventTitle.toString(),
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'GraphikRegular'),
                                  // softWrap: true,
                                  //  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
                                width: 20,
                                height: 20,
                                color: Color(0xff085196),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  item.eventdetailResult!.eventDate.toString(),
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'GraphikRegular'),
                                  //  softWrap: true,
                                  //  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Venue Address:",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'GraphikMedium'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  item.eventdetailResult!.venueAddress.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GraphikRegular',
                                  ),
                                  //  softWrap: true,

                                  // maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Html(
                            data: item.eventdetailResult!.eventDetail.toString(),
                            style: {
                              'h1': Style(color: Colors.red),
                              'p': Style(
                                  color: Colors.black87, fontSize: FontSize.xSmall),
                              'ul': Style(
                                  margin: const EdgeInsets.symmetric(vertical: 20))
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

   */

  Widget _buildListView(List<Eventlist> eventlist) {
    return ListView.builder(
        itemCount: eventlist.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EventsDetailPage(
                          eventDetailsRepo: widget.eventRepo,
                          eventid: eventlist[index].eventId.toString(),
                        )));
              },
              child: Card(
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    width: 100,
                    height: 125.9,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            flex: 2,
                            child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffF3F3F3)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xffF3F3F3)),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      "assets/images/no_image.png")),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: eventlist[index]
                                                  .eventImage
                                                  .toString(),
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            )))))),
                        Flexible(
                            flex: 5,
                            child: Container(
                              width: 320,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        eventlist[index].eventDate.toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'MuliRegular'),
                                      )),
                                  Text(
                                    eventlist[index].eventTitle.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'MuliSemiBold'),
                                  ),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        eventlist[index]
                                            .venueAddress
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'MuliRegular'),
                                      )),
                                ],
                              ),
                            )),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () => {},
                                icon: const Icon(
                                    Icons.arrow_circle_right_rounded)))
                      ],
                    ),
                  )));
        });
  }
}

class _EventDetails extends StatelessWidget {
  const _EventDetails({
    required this.eventtitle,
    required this.eventdate,
    required this.venuedetail,
  });

  final String? eventtitle;
  final String? eventdate;
  final String? venuedetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),

        Text(
          eventdate.toString(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Muli'),
        ),
        //const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        const Padding(padding: EdgeInsets.all(10.0)),
        Text(eventtitle.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Muli',
            ),
            //  softWrap: true,
            //  maxLines: 3,
            textAlign: TextAlign.center),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        Text(
          venuedetail.toString(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Muli'),
          //  softWrap: true,
          //  maxLines: 3,
        ),
        // const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
        Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.expand_circle_down_outlined)))
      ],
    );
  }
}

// Search Page
class SearchEventList extends StatefulWidget {
  List<Eventlist> eventlist;

  SearchEventList({required List<Eventlist> this.eventlist}) : super();

  @override
  State<SearchEventList> createState() => _SearchEventListState();
}

class _SearchEventListState extends State<SearchEventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
              hintText: 'Search Events...',
              border: InputBorder.none),
        ),
      ),
    )));
    body:
    _buildListView(widget.eventlist);
  }

  Widget _buildListView(List<Eventlist> eventlist) {
    print("length" + eventlist.length.toString());
    return ListView.builder(
        itemCount: eventlist.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: Card(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                      height: 200,
                      child: Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Image.network(
                            eventlist[index].eventImage.toString(),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: _EventDetails(
                                eventtitle: eventlist[index].eventTitle,
                                eventdate: eventlist[index].eventDate,
                                venuedetail: eventlist[index].venueAddress))
                      ]))));
          //trailing: ,
        });
  }
}
