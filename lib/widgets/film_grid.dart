import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/widgets/film_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmGrid extends StatefulWidget {
  @override
  _FilmGridState createState() => _FilmGridState();
}

class _FilmGridState extends State<FilmGrid> {
  bool isAvailableFilm = true;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onChangePage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      isAvailableFilm = !isAvailableFilm;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final films = Provider.of<Film>(context, listen: false).filmsAvailable;
    final filmsComing = Provider.of<Film>(context, listen: false).filmsComing;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  onChangePage(0);
                  setState(() {
                    isAvailableFilm = !isAvailableFilm;
                  });
                },
                child: Column(children: <Widget>[
                  AnimatedDefaultTextStyle(
                    style: isAvailableFilm
                        ? TextStyle(color: Colors.red)
                        : TextStyle(color: Colors.white),
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      "Phim đang chiếu ",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    color: Colors.red,
                    height: 5,
                    width: isAvailableFilm ? 100 : 0,
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () {
                  onChangePage(1);
                  setState(() {
                    isAvailableFilm = !isAvailableFilm;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(children: <Widget>[
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 200),
                      style: !isAvailableFilm
                          ? TextStyle(color: Colors.red)
                          : TextStyle(color: Colors.white),
                      child: Text(
                        "Phim sắp chiếu ",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: !isAvailableFilm ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      color: Colors.red,
                      height: 5,
                      width: !isAvailableFilm ? 100 : 0,
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(24, 24, 40, 1)),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              isAvailableFilm = !isAvailableFilm;
            });
          },
          children: <Widget>[
            ListView.builder(
              itemCount: films.length,
              itemBuilder: (ctx, index) => Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FilmItemWidget(films[index]),
              ),
            ),
            ListView.builder(
              itemCount: filmsComing.length,
              itemBuilder: (ctx, index) => Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FilmItemWidget(filmsComing[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
