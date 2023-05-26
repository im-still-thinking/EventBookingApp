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
  String appBarTitle = "Events";

  void toggleSearchBar() {
    setState(() {
      isSearchBarVisible = !isSearchBarVisible;
      searchValue = "";
      if(isSearchBarVisible){
        appBarTitle = "Search";
      }
      else{
        appBarTitle = "Events";
      }
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: isSearchBarVisible ? Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: toggleSearchBar,
          ),
        ) : null,
        title: isSearchBarVisible ? Text(
          appBarTitle,
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 24.0,
            ),
          ),
        ) : Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            appBarTitle,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 24.0,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: toggleSearchBar,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.more_vert,
              size: 30.0,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => EventsBloc(EventRepository()),
        child: Column(
          children: [
            if (isSearchBarVisible) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 0.9 * screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Type Event Name',
                      hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                          color: Color(0xff747688),
                        ),
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff5669ff),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchValue = value;
                      });
                    },
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  context
                      .read<EventsBloc>()
                      .add(SearchEvents(searchTerm: searchValue));
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
              Builder(builder: (context) {
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
              }),
            ]
          ],
        ),
      ),
    );
  }
}
