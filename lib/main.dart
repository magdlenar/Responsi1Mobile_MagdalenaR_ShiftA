import 'package:flutter/material.dart';
import 'package:manajemen_pariwasata/helpers/user_info.dart';
import 'package:manajemen_pariwasata/ui/login_page.dart';
import 'package:manajemen_pariwasata/ui/wisata_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const WisataPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destinasi Wisata',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
