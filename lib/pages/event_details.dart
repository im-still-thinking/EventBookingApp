import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_internet_folks_assignment/blocs/events/events_bloc.dart';
import 'package:the_internet_folks_assignment/util/event_repo.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsPage extends StatefulWidget {
  final int id;
  const EventDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            EventsBloc(EventRepository())..add(EventDetails(id: widget.id)),
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            ;
            if (state is EventDetailsLoaded) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        leading: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        backgroundColor: Colors.transparent, // Set background color to transparent
                        elevation: 0, // Remove shadow
                        title: Text(
                          'Event Details',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 24.0,
                              color: Color(0xff120d26),
                            ),
                          ),
                        ),
                        expandedHeight: 200,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                            state.event.bannerImage ?? "default",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 21.0, 24.0, 0.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 21.0),
                                child: Text(
                                  state.event.title ?? "default",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: screenWidth * 0.1,
                                      color: const Color(0xff120d26),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  NetworkImage(state.event.organizerIcon ?? "default"),
                                  size: 30.0,
                                ),
                                title: Text(
                                    state.event.organizerName ?? "default",
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0,
                                      color: Color(0xff120d26),
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  "Organizer",
                                ),
                              ),
                              const ListTile(
                                leading: Icon(
                                  Icons.calendar_month_outlined,
                                ),
                                title: Text("26 May 2023"),
                                subtitle: Text("Organizer"),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.location_pin
                                ),
                                title: Text(
                                    state.event.organizerName ?? "default"),
                                subtitle: const Text("Organizer"),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(21.0, 15.0, 8.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20.0),
                                      child: Text(
                                        "About Event",
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: screenWidth * 0.05,
                                            color: const Color(0xff120d26),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      state.event.description ?? "default",
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff120d26),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 16,
                    child: Center(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5669FF)
                          ),
                          onPressed: () {
                            // Handle button press
                          },
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text("Something Went wrong"),
            );
          },
        ),
      ),
    );
  }
}
