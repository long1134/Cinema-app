import 'package:cinema_app/providers/ticket_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketUserDetail extends StatelessWidget {
  static const routeName = '/film-ticket-user-detail';
  @override
  Widget build(BuildContext context) {
    TicketUserItem ticketUserItem =
        Provider.of<TicketUser>(context).getChoseTicket;
    print(ticketUserItem.filmName);
    String showTicketDetail() {
      String detail = "";
      for (var i in ticketUserItem.seatsDetail) {
        detail += i["name"].toString() + " (" + i["count"].toString() + ") ,";
      }
      return detail;
    }

    String showComboDetail() {
      String detail = "";
      print(ticketUserItem.foodDetail);
      if (ticketUserItem.foodDetail == null) {
        return "";
      }
      for (var i in ticketUserItem.foodDetail) {
        detail += i["name"].toString() + " (" + i["count"].toString() + ")";
      }
      return detail;
    }

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
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Mã QR : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.network(
                    "https://api.qrserver.com/v1/create-qr-code/?data=" +
                        ticketUserItem.id +
                        "&amp;size=100x100",
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tên phim : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngày chiếu : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Giờ chiếu : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ghế ngồi : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rạp : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thông tin ghế : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thông tin combo : ",
                        style:
                            TextStyle(color: Color.fromRGBO(99, 114, 134, 1)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ticketUserItem.filmName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ticketUserItem.dayShow.split("/").reversed.join("/"),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ticketUserItem.timeShow,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ticketUserItem.seatName,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ticketUserItem.cinemaName,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        showTicketDetail(),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        showComboDetail(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Tổng tiền thanh toán : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    ticketUserItem.price.toString() + " Đ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
