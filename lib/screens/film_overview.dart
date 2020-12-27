import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/widgets/app_drawer.dart';
import 'package:cinema_app/widgets/film_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmOverviewScreen extends StatefulWidget {
  @override
  _FilmOverviewScreenState createState() => _FilmOverviewScreenState();
}

class _FilmOverviewScreenState extends State<FilmOverviewScreen> {
  @override
  void didChangeDependencies() {
    if (Provider.of<Film>(context).filmsAvailable.length == 0) {
      Provider.of<Film>(context).getFilm().then((_) {
        setState(() {});
      });
    }
    Provider.of<Auth>(context).tryLogin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Row(
          children: <Widget>[
            Text("MOVIE "),
            Text(
              "CINEMA",
              style: TextStyle(color: Color.fromRGBO(248, 168, 40, 1)),
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: FilmGrid(),
    );
  }
}
