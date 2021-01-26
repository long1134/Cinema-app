import 'package:cinema_app/providers/ticket_user.dart';
import 'package:cinema_app/widgets/user_ticket_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketsUserScreen extends StatefulWidget {
  static const routeName = '/film-ticket-user';

  @override
  _TicketsUserScreenState createState() => _TicketsUserScreenState();
}

class _TicketsUserScreenState extends State<TicketsUserScreen> {
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    Provider.of<TicketUser>(context)
        .initUserTicket()
        .then((value) => {
              setState(() {
                isLoading = false;
              })
            })
        .catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TicketUser ticketUser = Provider.of<TicketUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Text(
          "Thông tin vé ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(24, 24, 40, 1),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ticketUser.items.length == 0
                ? Container(
                    child: Text(
                      "Your don't have ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: ticketUser.items.length,
                    itemBuilder: (ctx, i) {
                      return Container(
                          child: UserTicketItemWidget(ticketUser.items[i]));
                    },
                  ),
      ),
    );
  }
}
