import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../models/Event.dart';
import '../../util/event_repo.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository _eventRepository;

  EventsBloc(this._eventRepository) : super(EventsLoading ()) {
    on<LoadEvents>(_onLoadEvents);
    on<SearchEvents>(_onSearchEvents);
  }

  void _onLoadEvents(LoadEvents event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    try {
      final events = await _eventRepository.getEvents();
      emit(EventsLoaded(events: events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  void _onSearchEvents(SearchEvents event, Emitter<EventsState> emit) async {
    emit(SearchLoading());
    try {
      // print(event.searchTerm);
      final events = await _eventRepository.searchEvents(event.searchTerm);
      emit(SearchLoaded(events: events));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
