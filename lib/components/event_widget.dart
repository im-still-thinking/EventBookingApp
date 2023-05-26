import 'package:flutter/material.dart';
import 'package:the_internet_folks_assignment/models/Event.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_internet_folks_assignment/pages/event_details.dart';

class EventWidget extends StatelessWidget {
  EventWidget({super.key, required this.eventDetails}) {
    DateTime dateTime = DateTime.parse(eventDetails.dateTime ?? "");
    formattedDateString = DateFormat('EEE MMM d • HH:mm').format(dateTime);
    venueString = "${eventDetails.venueName} • ${eventDetails.venueCity}, ${eventDetails.venueCountry}";
  }

  String venueString = "";
  String formattedDateString = "";
  Event eventDetails;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailsPage(id: eventDetails.id ?? 0,)),
        );
      },
      child: Container(
        height: 0.14 * screenHeight,
        width: 0.9 * screenWidth,
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 35.0,
                offset: Offset(0, 10.0),
                color: Color.fromARGB(15, 87, 92, 138)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 7.0, 8.0, 7.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.25,
                    heightFactor: 1.0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        eventDetails.bannerImage ?? "default",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          formattedDateString,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 15.0,
                              color: Color(0xff5669ff),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Text(
                          eventDetails.title ?? "default",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 17.0,
                              color: Color(0xff120d26),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Color(0xff747688),
                              ),
                              const SizedBox(width: 7.75),
                              Text(
                                venueString,
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff747688),
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
            );
          }),
        ),
      ),
    );
  }
}
