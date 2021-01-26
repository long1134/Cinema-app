import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/screens/film_booking.dart';
import 'package:cinema_app/screens/film_count_seat.dart';
import 'package:cinema_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign-up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _usernameController = TextEditingController();
  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _emailFocusNode = FocusNode();
  var _addressFocusNode = FocusNode();
  var _fullnameFocusNode = FocusNode();
  var _phoneFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'username': '',
    'password': '',
    'phone': '',
    'email': '',
    'name': '',
    'address': '',
  };
  bool savePassword = true;
  bool isLoading = false;
  Response wrongField;
  void _saveForm() async {
    var isValid = _form.currentState.validate();
    setState(() {
      wrongField = null;
    });
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    await Provider.of<Auth>(context, listen: false)
        .register(
            _authData['username'],
            _authData['password'],
            _authData['email'],
            _authData['address'],
            _authData['name'],
            _authData['phone'])
        .then((result) async {
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
      if (result.body.indexOf('Tên đăng nhập') == -1 ||
          result.body.indexOf('Điện thoại') == -1 ||
          result.body.indexOf('Email') == -1) {
        return setState(() {
          wrongField = result;
        });
      } else {
        setState(() {
          wrongField = null;
        });
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
        });
      }
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
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _fullnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
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
              "Đăng ký",
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
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    onSaved: (value) {
                      _authData['username'] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập tên đăng nhập";
                      }
                      if (wrongField == null) return null;
                      if (wrongField.body.toString().indexOf('Tên đăng nhập') !=
                          -1) {
                        return "Tên đăng nhập bạn đã bị trùng ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Email",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    onSaved: (value) {
                      print(value);
                      _authData['email'] = value;
                    },
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return "Hãy nhập email";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value))
                        return "Email của bạn không chính xác";
                      if (wrongField == null) return null;
                      if (wrongField.body.toString().indexOf('Email') != -1) {
                        return "Email bạn đã bị trùng ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_fullnameFocusNode);
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
                    textInputAction: TextInputAction.next,
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
                    focusNode: _fullnameFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Họ và tên",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập Họ và tên";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_addressFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _phoneFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Số điện thoại",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    onSaved: (value) {
                      _authData['phone'] = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
                    ],
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập số điện thoại";
                      }
                      if (wrongField == null) return null;
                      if (wrongField.body.toString().indexOf('Điện thoại') !=
                          -1) {
                        return "Số điện thoại bạn đã bị trùng ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onFieldSubmitted: (value) {
                      _saveForm();
                    },
                    focusNode: _addressFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Địa chỉ",
                      errorStyle: TextStyle(
                        color: Color.fromRGBO(248, 168, 40, 1),
                      ),
                    ),
                    onSaved: (value) {
                      _authData['address'] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hãy nhập địa chỉ";
                      }
                      return null;
                    },
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
                                "ĐĂNG KÝ",
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
