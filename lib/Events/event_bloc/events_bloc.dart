import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../../repository/PtkmerchantRepository.dart';
import '../models/events_model.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  //
  List<Eventlist> eventdata = [];

//  final EventsRepository eventRepo;

  PtkmerchantRepository ptkrepository;
  //String accesstoken;

  EventsBloc({required this.ptkrepository})
      : super(EventsInitialState()) {
    on<EventsEvent>((event, emit) async {
      if (event is FetchEvents) {
        emit(EventsLoadingState());
        await Future.delayed(const Duration(seconds: 3), () async {
          eventdata = (await ptkrepository.fetchEventsData());
          emit(EventsLoaded(eventsList: eventdata));
        });
      }
    });
  }
}
