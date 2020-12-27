import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/combo.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:cinema_app/providers/ticket_user.dart';
import 'package:cinema_app/screens/film_booking.dart';
import 'package:cinema_app/screens/film_combo.dart';
import 'package:cinema_app/screens/film_count_seat.dart';
import 'package:cinema_app/screens/film_detail.dart';
import 'package:cinema_app/screens/film_map_seat.dart';
import 'package:cinema_app/screens/film_overview.dart';
import 'package:cinema_app/screens/login.dart';
import 'package:cinema_app/screens/ticket_book_success.dart';
import 'package:cinema_app/screens/ticket_detail.dart';
import 'package:cinema_app/screens/ticket_user_detail.dart';
import 'package:cinema_app/screens/tickets_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Film(),
        ),
        ChangeNotifierProvider.value(
          value: Cinema(),
        ),
        ChangeNotifierProvider.value(
          value: Showtime(),
        ),
        ChangeNotifierProvider.value(
          value: TicketCinemas(),
        ),
        ChangeNotifierProvider.value(
          value: Combo(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: TicketUser(),
        ),
      ],
      child: MaterialApp(
        home: FilmOverviewScreen(),
        routes: {
          FilmDetailScreen.routeName: (ctx) => FilmDetailScreen(),
          FilmBookingScreen.routeName: (ctx) => FilmBookingScreen(),
          FilmCountSeatScreen.routeName: (ctx) => FilmCountSeatScreen(),
          FilmMapSeatScreen.routeName: (ctx) => FilmMapSeatScreen(),
          FilmComboScreen.routeName: (ctx) => FilmComboScreen(),
          TicketDetailScreen.routeName: (ctx) => TicketDetailScreen(),
          TicketsUserScreen.routeName: (ctx) => TicketsUserScreen(),
          TicketUserDetail.routeName: (ctx) => TicketUserDetail(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          TicketBookSuccessScreen.routeName: (ctx) => TicketBookSuccessScreen(),
        },
      ),
    );
  }
}
