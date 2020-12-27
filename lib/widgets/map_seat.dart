import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapSeatWidget extends StatefulWidget {
  @override
  _MapSeatWidgetState createState() => _MapSeatWidgetState();
}

class _MapSeatWidgetState extends State<MapSeatWidget> {
  @override
  Widget build(BuildContext context) {
    ShowtimeItem showtime = Provider.of<Showtime>(context).getChoseShowtimeItem;
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: showtime.map[0].length * showtime.map.length,
        itemBuilder: (ctx, i) => Container(
          child: Container(
            height: 20,
            width: 20,
            child: GestureDetector(
              onTap: () {
                int countTicket =
                    Provider.of<TicketCinemas>(context).countTickets;
                int listTicket = Provider.of<Showtime>(context).tempList.length;
                print("long");
                print(listTicket);
                print(countTicket);
                Provider.of<TicketCinemas>(context).handleListTicket(
                    (i / 10).floor(),
                    i % 10,
                    showtime.map[(i / 10).floor()][i % 10] != 1);
                Provider.of<Showtime>(context).changeMapSeat(
                    (i / 10).floor(), i % 10, countTicket <= listTicket);
              },
              child: Icon(
                Icons.event_seat,
                color: showtime.map[(i / 10).floor()][i % 10] == 1
                    ? Color.fromRGBO(113, 113, 113, 1)
                    : showtime.map[(i / 10).floor()][i % 10] == 2
                        ? Color.fromRGBO(248, 168, 40, 1)
                        : Colors.white,
              ),
            ),
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 5 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
        ),
      ),
    );
  }
}
