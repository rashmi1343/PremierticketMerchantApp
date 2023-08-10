import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repository/PtkmerchantRepository.dart';
import '../models/eventsDetailResponse.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {

 late  EventsDetailResponse eventDetailsdata;

 String eventid;
  //List<DetailsResult>? eventDetailsdata;



  PtkmerchantRepository ptkrepository;
  // String accesstoken;
  // String accesskey;
  EventDetailsBloc({required this.ptkrepository,required this.eventid}) : super(EventDetailsInitial()) {
    on<EventDetailsEvent>((event, emit) async {
      emit(EventDetailsLoadingState());
      try {
         eventDetailsdata = await ptkrepository.eventdetailapi(eventid);
         print("eventDetailsdata:$eventDetailsdata");
        emit(EventDetailsLoaded(eventDetailsList:eventDetailsdata));
      } catch (e) {
        emit(EventDetailsErrorState( message: e.toString()));
      }
      // if (event is FetchDetailEvents) {
      //   emit(EventDetailsLoadingState());
      //   await Future.delayed(const Duration(seconds: 3), () async {
      //     eventDetailsdata= (await ptkrepository.eventdetailapi())!;
      //     emit(EventDetailsLoaded(eventDetailsList:eventDetailsdata));
      //   });
      // }
    });
  }
}
