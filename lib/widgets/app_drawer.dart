import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/screens/login.dart';
import 'package:cinema_app/screens/sign_up.dart';
import 'package:cinema_app/screens/tickets_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Drawer(
      child: Container(
        color: Color.fromRGBO(24, 24, 40, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              height: 15,
            ),
            auth.isAuth
                ? Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          auth.logout();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          child: Text(
                            "Đăng xuất",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: Color.fromRGBO(113, 113, 113, 1),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, TicketsUserScreen.routeName);
                        },
                        child: Container(
                          height: 40,
                          child: Text(
                            "Vé của bạn",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Container(
                          height: 40,
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: Color.fromRGBO(113, 113, 113, 1),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Container(
                          height: 40,
                          child: Text(
                            "Đăng Nhập",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
            Divider(
              height: 2,
              color: Color.fromRGBO(113, 113, 113, 1),
            ),
          ],
        ),
      ),
    );
  }
}
