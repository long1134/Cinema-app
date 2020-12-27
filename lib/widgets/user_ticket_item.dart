import 'package:cinema_app/providers/ticket_user.dart';
import 'package:cinema_app/screens/ticket_user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTicketItemWidget extends StatelessWidget {
  final TicketUserItem ticketUser;
  UserTicketItemWidget(this.ticketUser);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Color.fromRGBO(40, 40, 56, 1), border: Border.all(width: 0)),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    width: 80,
                    child: Image.network(
                      "https://long-cinema-app.herokuapp.com/api/h/film/img/" +
                          ticketUser.img,
                      fit: BoxFit.cover,
                      width: 100,
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
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            ticketUser.filmName,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Ngày chiếu : ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(87, 131, 165, 1),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ticketUser.dayShow
                                    .split("/")
                                    .reversed
                                    .join("/"),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Xuất chiếu : ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(99, 114, 134, 1),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ticketUser.timeShow,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            onPressed: () {
                              Provider.of<TicketUser>(context)
                                  .changeIdTicketChose(ticketUser.id);
                              Navigator.of(context)
                                  .pushNamed(TicketUserDetail.routeName);
                            },
                            child: Text("Chi tiết"),
                            color: Color.fromRGBO(248, 168, 40, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Tổng tiền thanh toán : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    ticketUser.price.toString() + " Đ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
