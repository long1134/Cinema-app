import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FilmItem with ChangeNotifier {
  final String id;
  final String name;
  final String director;
  final String dayShow;
  final String content;
  final String type;
  final String img1;
  final String img2;
  final double rate;
  final String trailer;
  final String status;
  final String time;
  final String country;

  FilmItem({
    @required this.id,
    @required this.name,
    @required this.dayShow,
    @required this.director,
    @required this.content,
    @required this.type,
    @required this.img1,
    @required this.img2,
    @required this.rate,
    @required this.trailer,
    @required this.status,
    @required this.time,
    @required this.country,
  });
}

class Film with ChangeNotifier {
  List<FilmItem> _filmsComing = [];
  List<FilmItem> _filmsAvailable = [];
  bool isFilmsAvailable = true;
  List<FilmItem> get filmsComing {
    return _filmsComing;
  }

  String idChose;

  FilmItem get getChoseFilm {
    FilmItem film =
        _filmsAvailable.firstWhere((e) => e.id == idChose, orElse: () => null);
    return film != null
        ? film
        : _filmsComing.firstWhere((e) => e.id == idChose);
  }

  void changeIndexFilm(String index) {
    idChose = index;
    notifyListeners();
  }

  List<FilmItem> get filmsAvailable {
    return _filmsAvailable;
  }

  void changeTypeFilm(int id) {
    this.isFilmsAvailable = !this.isFilmsAvailable;
    notifyListeners();
  }

  Future<void> getFilm() async {
    final client = new http.Client();
    const url = "https://long-cinema-app.herokuapp.com/api/quest/film";
    try {
      final response = await client.get(url);
      final data = json.decode(response.body) as List<dynamic>;
      final List<FilmItem> loadedFilmsAvalable = [];
      final List<FilmItem> loadedFilmsComing = [];
      data.forEach(
        (film) {
          if (film['status'] == "coming") {
            loadedFilmsComing.add(
              FilmItem(
                id: film['_id'],
                name: film['name'],
                dayShow: film['dayShow'],
                director: film['director'],
                content: film['content'],
                country: film['country'],
                type: film['type'],
                img1: film['img1'],
                img2: film['img2'],
                rate: double.parse(film['rate'].toString()),
                trailer: film['trailer'],
                status: film['status'],
                time: film['time'],
              ),
            );
          } else {
            loadedFilmsAvalable.add(
              FilmItem(
                id: film['_id'],
                name: film['name'],
                dayShow: film['dayShow'],
                director: film['director'],
                content: film['content'],
                country: film['country'],
                type: film['type'],
                img1: film['img1'],
                img2: film['img2'],
                rate: double.parse(film['rate'].toString()),
                trailer: film['trailer'],
                status: film['status'],
                time: film['time'],
              ),
            );
          }
        },
      );
      _filmsComing = loadedFilmsComing;
      _filmsAvailable = loadedFilmsAvalable;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  FilmItem findById(String id) {
    FilmItem film =
        _filmsAvailable.firstWhere((e) => e.id == id, orElse: () => null);
    return film != null
        ? film
        : _filmsComing.firstWhere((e) => e.id == id, orElse: () => null);
  }
}
