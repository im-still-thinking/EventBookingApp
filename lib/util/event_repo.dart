import 'dart:convert';

import 'package:the_internet_folks_assignment/models/Event.dart';
import 'package:http/http.dart';

class EventRepository{
  String eventURL = "https://sde-007.api.assignment.theinternetfolks.works/v1/event";
  String searchURL = "https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=";
  String detailsURL = "https://sde-007.api.assignment.theinternetfolks.works/v1/event/";

  Future<List<Event>> getEvents() async {
    Response eventResponse = await get(Uri.parse(eventURL));

    if (eventResponse.statusCode == 200){
      final List result = jsonDecode(eventResponse.body)["content"]["data"];
      return result.map((e) => Event.fromJson(e)).toList();
    }
    else{
      throw Exception(eventResponse.reasonPhrase);
    }
  }

  Future<List<Event>> searchEvents(String searchField) async{
    Response searchResponse = await get(Uri.parse(searchURL+searchField));

    if (searchResponse.statusCode == 200){
      final List result = jsonDecode(searchResponse.body)["content"]["data"];
      return result.map((e) => Event.fromJson(e)).toList();
    }
    else{
      throw Exception(searchResponse.reasonPhrase);
    }
  }

  Future<Event> getEventDetails(int id) async{
    Response eventDetailsResponse = await get(Uri.parse("$detailsURL$id"));

    if (eventDetailsResponse.statusCode == 200){
      final Map result = jsonDecode(eventDetailsResponse.body)["content"]["data"];
      return Event.fromJson(result);
    }
    else{
      throw Exception(eventDetailsResponse.reasonPhrase);
    }
  }
}