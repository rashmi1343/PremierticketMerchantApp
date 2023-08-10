part of 'event_details_bloc.dart';



@immutable
abstract class EventDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventDetailsInitial extends EventDetailsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventDetailsLoadingState extends EventDetailsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventDetailsLoaded extends EventDetailsState {
  EventsDetailResponse eventDetailsList;
 // List<DetailsResult> eventDetailsList;

  EventDetailsLoaded({required this.eventDetailsList});

  @override
  // TODO: implement props
  List<Object> get props => [eventDetailsList];
}

class EventDetailsErrorState extends EventDetailsState {
  String message;

  EventDetailsErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}