import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptk_merchant/Response/seatlayoutmodel.dart';
import 'package:ptk_merchant/repository/PtkmerchantRepository.dart';
import 'package:zoom_widget/zoom_widget.dart';


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class EventSeatLayout extends StatelessWidget {


// available seat
  BoxDecoration AvailableseatDecoration() {
    return BoxDecoration(
      //  color: Colors.red,
      color: Colors.white,
      border: Border.all(),
    );
  }

  BoxDecoration rowDecoration() {
    return BoxDecoration(
      color: Colors.black,
      border: Border.all(),
    );
  }

  BoxDecoration bookedseatDecoration() {
    final Color colorbooked = HexColor.fromHex('#5AC1DE');

    return BoxDecoration(
      color: colorbooked,
      border: Border.all(),
    );
  }



  List<Widget> createseat(String? rowname,List<SeatDetail> catSeats) {
    List<Widget> list = [];
   // print("seat length"+catSeats!.length.toString());
    for (int i = 0; i <=catSeats.length; i++) {

         // print("rowname_2:"+rowname.toString());

          if(rowname?.length!=0) {
          if(i==0) {
            list.add(Container( margin: const EdgeInsets.all(15.0),

                padding: const EdgeInsets.all(10.0),
                decoration: rowDecoration(), child:Text(rowname.toString(), style: TextStyle(
                  color: Colors.white))));

          }
          else if (i==catSeats.length) {
            list.add(Container( margin: const EdgeInsets.all(15.0),

                padding: const EdgeInsets.all(10.0),
                decoration: rowDecoration(), child:Text(rowname.toString(), style: TextStyle(
                    color: Colors.white))));

          }
          else {
              // blocked seat
              if(catSeats[i-1].seattype=="B") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }
              // booked seat
              else if(catSeats[i-1].seattype=="D") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }
              // Unavialable seat
              else if(catSeats[i-1].seattype=="N") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }
              //unavailable seat/blocked seat
              else if(catSeats[i-1].seattype=="A") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }
                // blocked seat
              else if(catSeats[i-1].seattype=="T") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }
              // handicapped seat
              else if(catSeats[i-1].seattype=="H") {
                list.add(Container(margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: bookedseatDecoration(),
                    child: Text(catSeats[i - 1].seatno)));
              }

              else {
                // available seat
                if (catSeats[i - 1].seatno?.length != 0) {
                  list.add(Container(margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: AvailableseatDecoration(),
                      child: Text(catSeats[i - 1].seatno))
                  );
                }
                else {
                  list.add(Container(margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      ));
                }
              }

        }


    }}


    return list;
  }
  var counter=0;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Scroller",
      home: Scaffold(
          body:
          Column(
              children: [
          Container(
          padding: const EdgeInsets.all(10),
        color: Colors.white,
        child:

       Center(child:
       Padding(
         padding: EdgeInsets.all(40),
        child: Text('Seat Layout'),

        ),
      )),
      Expanded(
          child: Zoom(
              maxZoomWidth:1800,
            maxZoomHeight: 800,
            child:
          FutureBuilder<List<TicketDetail>>(
              future: PtkmerchantRepository()
                  .getseatlayoutdata("getseatlayout", "10898", "3634"),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var datalength = snapshot.data?.length;
                  if (datalength == 0) {
                    return const Center(
                      child: Text('no data found'),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        print("index" + index.toString());
                        var singleChildScrollView = SingleChildScrollView(
                              child:
                              Row(
                                  children:
                                  createseat(snapshot.data?[0]
                                      .catSeats[index].seatDetail[index].rowName,
                                      snapshot.data![0]
                                          .catSeats[index].seatDetail)
                              ),

                              scrollDirection: Axis.horizontal);
                          return singleChildScrollView;


                      },

                      itemCount:
                      snapshot.data?.length,

                    );
                  }
                }
              }),
      ))

              ])
      ));
}

}
