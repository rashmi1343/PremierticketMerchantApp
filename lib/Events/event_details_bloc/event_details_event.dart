part of 'event_details_bloc.dart';

@immutable
abstract class EventDetailsEvent {

  @override
  List<Object> get props => [];
}


class FetchDetailEvents extends EventDetailsEvent {

  FetchDetailEvents();
}
