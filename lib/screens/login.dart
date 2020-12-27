import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/screens/film_booking.dart';
import 'package:cinema_app/screens/film_count_seat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _usernameController = TextEditingController();
  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  bool savePassword = true;
  bool isLoading = false;
  void _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    await Provider.of<Auth>(context, listen: false)
        .login(_authData['username'], _authData['password'])
        .then((_) {
      setState(() {
        isLoading = false;
      });
      bool isNewRouteBooking = false;
      Navigator.popUntil(context, (route) {
        if (route.settings.name == FilmBookingScreen.routeName) {
          isNewRouteBooking = true;
        }
        return true;
      });

      print("test");
      print(isNewRouteBooking);
      if (isNewRouteBooking) {
        return Navigator.pushNamed(context, FilmCountSeatScreen.routeName);
      } else
        Navigator.pop(context);
      print("login success");
    }).catchError((_) {
      setState(() {
        isLoading = false;
      });
      print("login fail");
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Đăng nhập",
              style: TextStyle(color: Color.fromRGBO(248, 168, 40, 1)),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(24, 24, 40, 1),
        child: ListView(
          children: <Widget>[
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    focusNode: _usernameFocusNode,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Tên đăng nhập",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (value) {
                      _authData['username'] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập tên đăng nhập";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    onFieldSubmitted: (value) {
                      _saveForm();
                    },
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Mật khẩu",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập mật khẩu";
                      }
                      return null;
                    },
                  ),
                  Theme(
                    data: ThemeData(
                        unselectedWidgetColor: Color.fromRGBO(248, 168, 40, 1)),
                    child: CheckboxListTile(
                      activeColor: Color.fromRGBO(248, 168, 40, 1),
                      checkColor: Color.fromRGBO(24, 24, 40, 1),
                      title: Text(
                        "Lưu mật khẩu",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      value: savePassword,
                      onChanged: (bool value) {
                        setState(() {
                          savePassword = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: FlatButton(
                              color: Color.fromRGBO(248, 168, 40, 1),
                              child: Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _saveForm();
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 4),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Color.fromRGBO(24, 24, 40, 1),
                            ),
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
