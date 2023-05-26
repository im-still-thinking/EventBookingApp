import 'package:flutter/material.dart';
import 'package:the_internet_folks_assignment/blocs/events/events_bloc.dart';
import 'package:the_internet_folks_assignment/pages/events.dart';
import 'package:the_internet_folks_assignment/util/event_repo.dart';
import 'package:the_internet_folks_assignment/util/light_theme_material3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const lightTheme = LightThemeMaterial3();
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
          create: (context) => EventsBloc(
            EventRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'The Internet Folks Assignment',
        debugShowCheckedModeBanner: false,
        theme: lightTheme.toThemeData(),
        home: const EventPage(),
      ),
    );
  }
}
