import 'package:equatable/equatable.dart';

class Event extends Equatable {
  int? id;
  String? title;
  String? bannerImage;
  String? dateTime;
  String? organizerName;
  String? organizerIcon;
  String? venueName;
  String? venueCity;
  String? venueCountry;

  Event({
    required this.id,
    required this.title,
    required this.bannerImage,
    required this.dateTime,
    required this.organizerName,
    required this.organizerIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  Event.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    dateTime = json['date_time'];
    organizerName = json['organizer_name'];
    organizerIcon = json['organizer_icon'];
    venueName = json['venue_name'];
    venueCity = json['venue_city'];
    venueCountry = json['venue_country'];
  }

  @override
  List<Object?> get props => [
        id,
        title,
        bannerImage,
        dateTime,
        organizerName,
        organizerIcon,
        venueName,
        venueCity,
        venueCountry,
  ];
}
