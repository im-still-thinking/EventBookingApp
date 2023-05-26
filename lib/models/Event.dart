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
  String? description;

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
    required this.description,
  });

  Event.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    dateTime = json['date_time'];
    organizerName = json['organiser_name'];
    organizerIcon = json['organiser_icon'];
    venueName = json['venue_name'];
    venueCity = json['venue_city'];
    venueCountry = json['venue_country'];
    description = json['description'];
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
