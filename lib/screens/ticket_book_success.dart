import 'package:flutter/material.dart';

class TicketBookSuccessScreen extends StatelessWidget {
  static const routeName = '/film-ticket-book-success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Text(
          "Thông tin vé ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(24, 24, 40, 1),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  "Bạn đã đặt vé thành công",
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text("Trang chủ"),
                  color: Color.fromRGBO(248, 168, 40, 1),
                ),
              ],
            ),
          )),
    );
  }
}
