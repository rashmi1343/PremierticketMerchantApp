import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../Payment/Payment.dart';
import '../../Request/CustomerOrderInfoRequest.dart';
import '../../Request/cartinformationRequest.dart';
import '../../Request/nonSeatingRequest.dart';

import '../../Response/CartinformationResponse.dart';
import '../../repository/PtkmerchantRepository.dart';
import '../../util/appConstant.dart';
import '../event_details_bloc/event_details_bloc.dart';
import '../models/eventsDetailResponse.dart';
import 'EventLayout/NonSeatingEventsWidget.dart';
// import 'EventLayout/Seatits/SeatingEventWidget.dart';

class EventCheckoutPage extends StatefulWidget {
  final PtkmerchantRepository eventDetailsRepo;
  EventsDetailResponse eventDetaillist;
  // String eventid;

  EventCheckoutPage(
      {required this.eventDetailsRepo,
      // required this.eventid,
      required this.eventDetaillist})
      : assert(eventDetailsRepo != null),
        super();

  @override
  _EventCheckoutPageState createState() => _EventCheckoutPageState();
}

class _EventCheckoutPageState extends State<EventCheckoutPage> {
  late EventDetailsBloc eventDetailsBloc;
  bool _searchBoolean = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool formIsValid = false;
  bool isSeatingEvent = false;
  final TextEditingController _discountCodeController = TextEditingController();
  PtkmerchantRepository get _eventDetailsRepository => widget.eventDetailsRepo;

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 10);

  double subTotal = 0.0;
  double totalAmount = 0.0;

  final NonSeatingRequest _nonSeatingRequest = NonSeatingRequest();
  final CustomerOrderInfoRequest _orderInfoRequest = CustomerOrderInfoRequest();
  final CartinformationRequest _cartinformationRequest =
      CartinformationRequest();

  final Plandetail _plandetail = Plandetail();
  CartinformationResponse cartinformationResponse = CartinformationResponse();

  @override
  void initState() {
    // eventDetailsBloc = EventDetailsBloc(
    //     ptkrepository: _eventDetailsRepository,
    //     eventid: widget.eventid.toString());
    //eventDetailsBloc.add(FetchDetailEvents());
    getSelectedCategorySubTotal(widget.eventDetaillist.result
        ?.ticketInformationNonSeating as List<TicketInformationNonSeating>);
    super.initState();
    startTimer();

    if (widget.eventDetaillist.result?.isSeatBooking == "0") {
      callApi(); // Non Seating Event
    }
  }

  callApi() async {
    await callNonSeatingDataApi();
    await callOrderInfoDataApi();
    await callCartinformationApi();
  }

  callNonSeatingDataApi() {
    _nonSeatingRequest.method = "nonseatingaddcart";
    _nonSeatingRequest.customersesid = widget.eventDetaillist.requestsessionid;
    _nonSeatingRequest.eventId =
        widget.eventDetaillist.result?.eventId.toString();

    if (widget.eventDetaillist.result?.eventTicketIdNonSeating != false) {
      // eventTicketIdNonSeating coming false in some response.
      _nonSeatingRequest.ticketId =
          widget.eventDetaillist.result?.eventTicketIdNonSeating;
    } else {
      final List<String>? ticketIds = widget
          .eventDetaillist.result?.ticketInformationNonSeating!
          .map((ticketId) => ticketId.ticketId.toString())
          .toList();
      final string = ticketIds!.reduce((value, element) => '$value,$element');
      print(string);
      _nonSeatingRequest.ticketId = string;
    }

    _nonSeatingRequest.attendeeDetail = "";
    _nonSeatingRequest.ticketQuantity =
        widget.eventDetaillist.result?.ticketQtyArray;
    _nonSeatingRequest.authkey = ApiConstant.getAuthKeyBaseString();

    _eventDetailsRepository.nonSeatingAddToCartApi(_nonSeatingRequest);
  }

  callOrderInfoDataApi() {
    _orderInfoRequest.methodname = "customerorderinfo";
    _orderInfoRequest.customersesid = widget.eventDetaillist.requestsessionid;
    _orderInfoRequest.eventId =
        widget.eventDetaillist.result?.eventId.toString();

    if (widget.eventDetaillist.result?.eventTicketIdNonSeating != false) {
      // eventTicketIdNonSeating coming false in some response.
      _orderInfoRequest.ticketId =
          widget.eventDetaillist.result?.eventTicketIdNonSeating;
    } else {
      final List<String>? ticketIds = widget
          .eventDetaillist.result?.ticketInformationNonSeating!
          .map((ticketId) => ticketId.ticketId.toString())
          .toList();
      final string = ticketIds!.reduce((value, element) => '$value,$element');
      print(string);
      _orderInfoRequest.ticketId = string;
    }

    _orderInfoRequest.eventType =
        widget.eventDetaillist.result?.eventType.toString();
    _orderInfoRequest.postcode = widget.eventDetaillist.result?.isSeatBooking;
    _orderInfoRequest.isSeatBooking =
        widget.eventDetaillist.result?.isSeatBooking;
    _orderInfoRequest.seatId = "";
    _orderInfoRequest.showId = "";
    _orderInfoRequest.ticketPrice = "";
    _orderInfoRequest.firstName = "";
    _orderInfoRequest.lastName = "";

    _orderInfoRequest.email = "";
    _orderInfoRequest.mobile = "";
    _orderInfoRequest.address = "";
    _orderInfoRequest.suburb = "";
    _orderInfoRequest.country = "";

    _orderInfoRequest.state = "";
    _orderInfoRequest.customerId = "";
    _orderInfoRequest.bookingTotalPrice = "";
    _orderInfoRequest.customerFee = "";
    _orderInfoRequest.promoterFee = "";

    _orderInfoRequest.plandetail = [];
    _orderInfoRequest.authkey = ApiConstant.getAuthKeyBaseString();

    _eventDetailsRepository.customerOrderInfoApi(_orderInfoRequest);
  }

  callCartinformationApi() {
    _cartinformationRequest.methodname = "cartinformaton";
    _cartinformationRequest.customersesid =
        widget.eventDetaillist.requestsessionid;
    _cartinformationRequest.eventId =
        widget.eventDetaillist.result?.eventId.toString();

    if (widget.eventDetaillist.result?.eventTicketIdNonSeating != false) {
      // eventTicketIdNonSeating coming false in some response.
      _cartinformationRequest.ticketId =
          widget.eventDetaillist.result?.eventTicketIdNonSeating;
    } else {
      final List<String>? ticketIds = widget
          .eventDetaillist.result?.ticketInformationNonSeating!
          .map((ticketId) => ticketId.ticketId.toString())
          .toList();
      final string = ticketIds!.reduce((value, element) => '$value,$element');
      print(string);
      _cartinformationRequest.ticketId = string;
    }
    _cartinformationRequest.eventType =
        widget.eventDetaillist.result?.eventType.toString();
    _cartinformationRequest.isMobilerequest = "1";
    _cartinformationRequest.userRoleType = "2";
    _cartinformationRequest.authkey = ApiConstant.getAuthKeyBaseString();

    _eventDetailsRepository
        .customerCartinformationApi(_cartinformationRequest)
        .then((response) =>
            // print("_paymentMethods: ${response.result?.paymentMethod![0].methodName ?? []}"));
            cartinformationResponse = response);
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _discountCodeController.dispose();
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
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
            // title: const Text(
            //   "Event Details",
            //   style: TextStyle(
            //     fontFamily: "MuliRegularMedium",
            //     fontSize: 17,
            //     color: Color(0xff243444),
            //   ),
            // ),
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
          resizeToAvoidBottomInset: true,
          body: _buildListView(widget.eventDetaillist)
          //  BlocBuilder<EventDetailsBloc, EventDetailsState>(
          //   bloc: eventDetailsBloc,
          //   builder: (
          //     BuildContext context,
          //     EventDetailsState state,
          //   ) {
          //     if (state is EventDetailsInitial) {
          //       print("initial state");
          //       return buildLoading();
          //     } else if (state is EventDetailsLoaded) {
          //       print("loaded state");
          //       print("eventDetaillist:${state.eventDetailsList}");
          // return _buildListView(state.eventDetailsList);
          //     } else if (state is EventDetailsErrorState) {
          //       print("error state");
          //       return buildErrorUi(state.message);
          //     } else {
          //       print("loading progress state");
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
          );
    });
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
          style: const TextStyle(
            color: Colors.red,
            fontFamily: 'MuliRegular',
          ),
        ),
      ),
    );
  }

  Widget _buildListView(EventsDetailResponse eventDetaillist) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 3.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$minutes:$seconds',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MuliRegular',
                          color: Color(0xffda2727),
                          fontSize: 21),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      'Time to Complete Your Purchase',
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MuliRegular',
                          color: Color.fromARGB(255, 91, 92, 93)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 3.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: const EdgeInsets.only(left: 10, right: 5),
                  title: const Text(
                    'Event Details',
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MuliRegular',
                        color: Color.fromARGB(255, 91, 92, 93)),
                  ),
                  children: <Widget>[
                    Column(children: [
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
                                  fontSize: 19,
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
                                  fontSize: 16,
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
                                  fontSize: 16,
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
                      Container(
                        // color: Colors.transparent.withOpacity(0.5),
                        height: 40,
                        width: double.infinity,
                        margin: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: null,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Change",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'MuliRegular',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ]),
                  ]),
            ),
            Container(
              // width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 3.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 10, right: 5),
                  title: const Text(
                    'Customer Details',
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MuliRegular',
                        color: Color.fromARGB(255, 91, 92, 93)),
                  ),
                  // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Chetan Lodhi',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17,
                                    height: 1.3,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'MuliRegular',
                                    color: Color.fromARGB(255, 91, 92, 93)),
                                // softWrap: true,
                                //  maxLines: 3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                '+922-9876543298',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17,
                                    height: 1.3,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'MuliRegular',
                                    color: Color.fromARGB(255, 91, 92, 93)),
                                // softWrap: true,
                                //  maxLines: 3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'chetan.l@broadwayinfotech.com',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17,
                                    height: 1.3,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'MuliRegular',
                                    color: Color.fromARGB(255, 91, 92, 93)),
                                // softWrap: true,
                                //  maxLines: 3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ]),
                      ),
                    ),
                  ]),
            ),
            Container(
              // width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffB4B4B4),
                    blurRadius: 3.0,
                  ),
                ],
                color: const Color(0xffffffff),
              ),
              child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 10, right: 5),
                  title: const Text(
                    'Order Details',
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MuliRegular',
                        color: Color.fromARGB(255, 91, 92, 93)),
                  ),
                  children: <Widget>[
                    Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.eventDetaillist.result
                                      ?.ticketInformationNonSeating !=
                                  null
                              ? _buildNonSeatingTicketListView(widget
                                      .eventDetaillist
                                      .result
                                      ?.ticketInformationNonSeating
                                  as List<TicketInformationNonSeating>)
                              : _buildSeatingTicketListView(widget
                                  .eventDetaillist.result?.ticketInformation),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, bottom: 10),
                            // alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sub Total:\t",
                                  style: TextStyle(
                                      height: 1.2,
                                      fontSize: 16,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                                Text(
                                  "${widget.eventDetaillist.result?.currencySymbol}$subTotal",
                                  style: const TextStyle(
                                      height: 1.2,
                                      fontSize: 16,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              right: 10,
                            ),
                            // alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Booking Fee:\t",
                                  style: TextStyle(
                                      height: 1.2,
                                      fontSize: 16,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                                Text(
                                  "${widget.eventDetaillist.result?.currencySymbol}0.0",
                                  style: const TextStyle(
                                      height: 1.2,
                                      fontSize: 16,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 10,
                            ),
                            // alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total Amount:\t",
                                  style: TextStyle(
                                      height: 1.2,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                                Text(
                                  "${widget.eventDetaillist.result?.currencySymbol}$subTotal",
                                  style: const TextStyle(
                                      height: 1.2,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'MuliRegular',
                                      color: Color(0xff313131)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 45,
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff00a400))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PaymentForm(
                                          cartinformationResponse:
                                              cartinformationResponse,
                                        )));
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    fontFamily: 'MuliRegular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.transparent.withOpacity(0.5),
                            height: 40,
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 0, right: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: null,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Change",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'MuliRegular',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ]),
            ),
            Form(
              key: _formKey,
              // onChanged: () => setState(
              //     () => formIsValid = _formKey.currentState!.validate()),
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                // width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: const Color(0xffF3F3F3)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffB4B4B4),
                      blurRadius: 3.0,
                    ),
                  ],
                  color: const Color(0xffffffff),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 5),
                        child: Text(
                          'Have a discount code?',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MuliRegular',
                              color: Color.fromARGB(255, 91, 92, 93)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.only(left: 10, right: 5),
                        child: TextFormField(
                          controller: _discountCodeController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.name,
                          // onChanged: (String value) {},
                          enableSuggestions: false,
                          decoration: InputDecoration(
                              suffixIcon: Container(
                                // color: Colors.transparent.withOpacity(0.5),
                                height: 40,
                                width: 100,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 119, 119, 119))),
                                  onPressed: null,
                                  child: const Text(
                                    "Apply",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'MuliRegular',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 157, 157, 157),
                                      width: 0.5)),
                              hintStyle: const TextStyle(
                                  fontSize: 15, fontFamily: "MuliRegular"),
                              hintText: 'Enter Promocode',
                              // errorText: 'please enter valid discount code',
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatingTicketListView(
      List<TicketInformation> seatingTicketList) {
    return Container();
  }

  getSelectedCategorySubTotal(
      List<TicketInformationNonSeating> nonSeatingTicketList) {
    for (var i = 0; i < nonSeatingTicketList.length; i++) {
      if (nonSeatingTicketList[i].ticketQty != null) {
        subTotal += double.parse(nonSeatingTicketList[i].ticketQty ?? "") *
            double.parse(nonSeatingTicketList[i].ticketPrice ?? "");
      }
    }
  }

  Widget _buildNonSeatingTicketListView(
      List<TicketInformationNonSeating> nonSeatingTicketList) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: nonSeatingTicketList.length,
        itemBuilder: (BuildContext context, int index) {
          //print(nonSeatingTicketList[index].ticketQty);

          return (nonSeatingTicketList[index].ticketQty) != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nonSeatingTicketList[index].ticketName ?? "",
                        style: const TextStyle(
                          fontFamily: 'MuliRegular',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${nonSeatingTicketList[index].ticketQty ?? ""} x ${widget.eventDetaillist.result?.currencySymbol}${nonSeatingTicketList[index].ticketPrice ?? ""}\t\t\t',
                            style: const TextStyle(
                              fontFamily: 'MuliRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${widget.eventDetaillist.result?.currencySymbol}${double.parse(nonSeatingTicketList[index].ticketQty ?? "") * double.parse(nonSeatingTicketList[index].ticketPrice ?? "")}",
                            style: const TextStyle(
                              fontFamily: 'MuliRegular',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 1,
                      ),
                    ],
                  ))
              : Container(
                  height: 0,
                );
          //trailing: ,
        });
  }
}
