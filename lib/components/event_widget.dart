import 'package:flutter/material.dart';
import 'package:the_internet_folks_assignment/models/Event.dart';

class EventWidget extends StatelessWidget {
  EventWidget({
    super.key,
    required this.eventDetails
  });

  Event eventDetails;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 0.14 * screenHeight,
      width: 0.9 * screenWidth,
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Wed, Apr 28 • 5:30 PM"),
                      Text(eventDetails.title ?? "default"),
                      const Row(
                        children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 7.75),
                          Text("Holaaa"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
