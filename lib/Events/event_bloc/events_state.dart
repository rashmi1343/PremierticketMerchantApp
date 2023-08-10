part of 'events_bloc.dart';

@immutable
abstract class EventsState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventsInitialState extends EventsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventsLoadingState extends EventsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventsLoaded extends EventsState {
  List<Eventlist> eventsList;

  EventsLoaded({required this.eventsList});

  @override
  // TODO: implement props
  List<Object> get props => [eventsList];
}

class EventsErrorState extends EventsState {
  String message;

  EventsErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}