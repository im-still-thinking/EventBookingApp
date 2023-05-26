import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_internet_folks_assignment/components/event_widget.dart';
import 'package:the_internet_folks_assignment/util/event_repo.dart';
import '../blocs/events/events_bloc.dart';
import 'package:the_internet_folks_assignment/models/Event.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isSearchBarVisible = false;
  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  void toggleSearchBar() {
    setState(() {
      isSearchBarVisible = !isSearchBarVisible;
      searchController.clear();
    });
  }

  void clearSearchField() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Events",
            style: GoogleFonts.getFont('Inter')
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: toggleSearchBar,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => EventsBloc(EventRepository()),
        child: Column(
          children: [
            if (isSearchBarVisible) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearSearchField,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchValue = value;
                    });
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  context.read<EventsBloc>().add(SearchEvents(searchTerm: searchValue));
                  return Expanded(
                    child: BlocBuilder<EventsBloc, EventsState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SearchLoaded) {
                          List<Event> eventsList = state.events;
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(24.0, 3.0, 24.0, 1.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: eventsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return EventWidget(
                                    eventDetails: eventsList[index]);
                              },
                            ),
                          );
                        }
                        return const Center(
                          child: Text("Something Went wrong"),
                        );
                      },
                    ),
                  );
                },
              ),
            ] else ...[
              Builder(
                builder: (context) {
                  context.read<EventsBloc>().add(LoadEvents());
                  return Expanded(
                    child: BlocBuilder<EventsBloc, EventsState>(
                      builder: (context, state) {
                        if (state is EventsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is EventsLoaded) {
                          List<Event> eventsList = state.events;
                          return Padding(
                            padding:
                            const EdgeInsets.fromLTRB(24.0, 3.0, 24.0, 1.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: eventsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return EventWidget(
                                    eventDetails: eventsList[index]);
                              },
                            ),
                          );
                        }
                        return const Center(
                          child: Text("Something Went wrong"),
                        );
                      },
                    ),
                  );
                }
              ),
            ]
          ],
        ),
      ),
    );
  }
}
