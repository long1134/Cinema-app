import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/combo.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/widgets/showtime_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmBookingScreen extends StatefulWidget {
  static const routeName = '/film-booking';

  @override
  _FilmBookingScreenState createState() => _FilmBookingScreenState();
}

class _FilmBookingScreenState extends State<FilmBookingScreen> {
  var initIndexDate = 0;
  var isChoseDate = false;
  @override
  void didChangeDependencies() {
    if (Provider.of<Showtime>(context).items.length == 0) {
      final filmtId = ModalRoute.of(context).settings.arguments as String;
      Provider.of<Showtime>(context)
          .initShowtime(filmtId, "2021/1/26")
          .then((_) {
        setState(() {});
      });
    }
    if (Provider.of<Cinema>(context).items.length == 0) {
      Provider.of<Cinema>(context).getCinema().then((_) {
        setState(() {});
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cinema = Provider.of<Cinema>(context, listen: false).items;
    var date = new DateTime.now();
    const dayOfWeek = ["hai", "ba", "tư", "năm", "sáu", "bảy", "chủ nhật"];
    final filmtId = ModalRoute.of(context).settings.arguments as String;
    final loadedFilm = Provider.of<Film>(context).findById(filmtId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Text(loadedFilm.name),
      ),
      body: cinema.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(15),
              color: Color.fromRGBO(24, 24, 40, 1),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isChoseDate = true;
                              initIndexDate = index;
                            });
                            var dateSelected =
                                new DateTime(2021, 1, 26 + index).day;
                            var monthSelected =
                                new DateTime(2021, 1, 26 + index).month;
                            var temp = "2021/" +
                                monthSelected.toString() +
                                "/" +
                                dateSelected.toString();
                            Provider.of<Showtime>(context).changeTime(temp);
                            Provider.of<Combo>(context).initTicket();
                            Provider.of<Showtime>(context)
                                .initShowtime(filmtId, temp)
                                .then((_) {
                              setState(() {
                                isChoseDate = false;
                              });
                            });
                          },
                          child: Container(
                            width: 70,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: initIndexDate == index
                                    ? Color.fromRGBO(47, 81, 243, 1)
                                    : Color.fromRGBO(24, 24, 40, 1)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    (date.day + index).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    (date.weekday + index != 7 ? "thứ " : "") +
                                        (dayOfWeek[
                                                (date.weekday - 1 + index) % 7])
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height - 60,
                    child: cinema.length == 0
                        ? Container()
                        : isChoseDate
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: cinema.length,
                                itemBuilder: (ctx, index) {
                                  return ShowtimeItemWidget(
                                      cinema[index], filmtId);
                                },
                              ),
                  )
                ],
              ),
            ),
    );
  }
}
