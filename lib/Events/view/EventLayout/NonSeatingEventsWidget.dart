import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../repository/PtkmerchantRepository.dart';
import '../../event_details_bloc/event_details_bloc.dart';
import '../../models/eventsDetailResponse.dart';
import '../EventCheckout.dart';

class NonSeatingEventsWidget extends StatefulWidget {
  EventsDetailResponse eventDetaillist;
  PtkmerchantRepository eventDetailsRepo;
  NonSeatingEventsWidget(
      {required this.eventDetaillist, required this.eventDetailsRepo});

  @override
  _NonSeatingEventsWidgetState createState() => _NonSeatingEventsWidgetState();
}

class _NonSeatingEventsWidgetState extends State<NonSeatingEventsWidget> {
  late EventDetailsBloc eventDetailsBloc;
  bool _searchBoolean = false;

  bool _isBookNowBtnShow = true;

  List<String> selectedItemValue = [];
  List<String> maxTicketList = [];
  List<String> maxQtyList = [];

  List<TicketInformationNonSeating> selectedNonSeatingQtyArr = [];

  @override
  void initState() {
    super.initState();

    if (widget.eventDetaillist.result?.ticketInformationNonSeating?.isEmpty ??
        false) {
      _isBookNowBtnShow = !_isBookNowBtnShow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isBookNowBtnShow,
      child: Container(
        // height: 200,
        child: Column(children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.eventDetaillist.result
                    ?.ticketInformationNonSeating?.length ??
                0,
            itemBuilder: (context, index) {
              for (int i = 0;
                  i <
                      int.parse(widget
                              .eventDetaillist
                              .result
                              ?.ticketInformationNonSeating?[index]
                              .maxTicketBooking ??
                          "");
                  i++) {
                selectedItemValue.add('Qty');
              }

              return ListTile(
                title: Text(
                  widget.eventDetaillist.result
                          ?.ticketInformationNonSeating?[index].ticketName ??
                      "",
                  style: const TextStyle(
                    height: 1.2,
                    fontSize: 17,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'MuliRegular',
                    fontWeight: FontWeight.w800,
                    color: Color(0xff313131),
                  ),
                ),
                subtitle: Text(
                  "${widget.eventDetaillist.result?.currencySymbol}${widget.eventDetaillist.result?.ticketInformationNonSeating?[index].ticketPrice ?? ""}",
                  style: const TextStyle(
                    height: 1.2,
                    fontSize: 15,
                    // fontWeight: FontWeight.normal,
                    fontFamily: 'MuliRegular',
                    color: Color(0xff313131),
                  ),
                ),
                trailing: Container(
                  width: 75,
                  //height: 50,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: AlignmentDirectional.centerStart,
                          items: _dropDownItem(index),
                          onChanged: (value) {
                            selectedItemValue[index] = value ?? "";
                            if (value != "Qty") {
                              widget
                                  .eventDetaillist
                                  .result
                                  ?.ticketInformationNonSeating?[index]
                                  .ticketQty = value ?? "0";
                            } else {
                              widget
                                  .eventDetaillist
                                  .result
                                  ?.ticketInformationNonSeating?[index]
                                  .ticketQty = null;
                            }
                            print(widget
                                .eventDetaillist
                                .result
                                ?.ticketInformationNonSeating?[index]
                                .ticketQty);
                            setState(() {});
                          },
                          value: selectedItemValue[index].toString(),
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
          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff00a400))),
              onPressed: () {
                createTicketQtyArray();
              },
              child: const Text(
                "Book Now",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'MuliRegular',
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }

  createTicketQtyArray() {
    final arr = widget.eventDetaillist.result?.ticketInformationNonSeating
        as List<TicketInformationNonSeating>;
    List<TicketInformationNonSeating> qtyDataArr =
        arr.where((ticket) => ticket.ticketQty != null).toList();
    List<String> finalStrArr = [];

    widget.eventDetaillist.result?.ticketQtyArray = null;

    for (var i = 0; i < qtyDataArr.length; i++) {
      final data = qtyDataArr[i];
      final finalStr = "${data.ticketId}###${data.ticketQty}";
      finalStrArr.add(finalStr);
      widget.eventDetaillist.result?.ticketQtyArray = finalStrArr;
      print(widget.eventDetaillist.result?.ticketQtyArray);
    }

    final tktQtyArr = widget.eventDetaillist.result?.ticketQtyArray;
    print(tktQtyArr);
    if (tktQtyArr != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventCheckoutPage(
                eventDetaillist: widget.eventDetaillist,
                eventDetailsRepo: widget.eventDetailsRepo,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select ticket quantity before proceed.',
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
    }
  }

  List<DropdownMenuItem<String>> _dropDownItem(int index) {
    maxQtyList = [];
    maxTicketList = [];

    for (int i = 0;
        i <
            int.parse(widget.eventDetaillist.result
                    ?.ticketInformationNonSeating?[index].maxTicketBooking ??
                "");
        i++) {
      maxTicketList.add((i + 1).toString());
    }

    List<String> ddl = ["Qty"]; // Adding QTY at 0 index
    maxQtyList = ddl + maxTicketList;
    // print(maxQtyList);
    return maxQtyList
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
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
}
