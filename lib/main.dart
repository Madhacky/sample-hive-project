import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_app/FormDataItem.dart';
import 'package:login_app/initialpage.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'LoginApp.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.purple,
    ),
    title: "Login App",
    home: LoginApp(),
  ));
}

///login API
const rootUrl = 'https://imdrm.pilogcloud.com';
