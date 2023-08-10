part of 'events_bloc.dart';

@immutable
abstract class EventsEvent {
  @override
  List<Object> get props => [];
}


class FetchEvents extends EventsEvent {
//List<Eventlist>eventslist=[];

  //FetchEvents(this.eventslist);
  FetchEvents();
}