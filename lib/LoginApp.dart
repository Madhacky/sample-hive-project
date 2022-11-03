import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:login_app/offlinedraft.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePageScreen.dart';
import 'main.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  late SharedPreferences logindata;
  late bool newuser;

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => HomePageScreen()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameText.dispose();
    passWordText.dispose();
    super.dispose();
  }

  String userName = '', passWord = '';
  /*String instance = '',
      plant = '',
      roleId = '',
      locale = '',
      env = '',
      orgn = '';*/
  bool userError = false, showPasswordField = false, passError = false;
  final userNameText = TextEditingController();
  final passWordText = TextEditingController();
  bool _visible = true;
  var box;
  var fetchResults = [];
  clearText() {
    userNameText.clear();
    passWordText.clear();
  }

  @override
  initState() {
    check_if_already_login();
    super.initState();
    userName = 'SASI_MGR';
    userNameText.text = 'SASI_MGR';
    passWord = 'P@ssw0rd';
    passWordText.text = 'P@ssw0rd';
  }

  void click() {}
  @override
  Widget build(BuildContext context) {
    AnimationController animateController;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(11, 74, 153, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              icon: Icon(Icons.drafts),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OfflineDraft(box)));
              },
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 15, top: 100, right: 20, left: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // s
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset(
                              'assets/Images/PiLog Logo.png',
                            ),
                          ),
                          /*const Text(
                    "iFAR",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),*/
                          /*const SizedBox(
                    height: 10,
                  ),*/
                          const Text(
                            "Please Login to Your Account",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: SlideInLeft(
                                duration: Duration(milliseconds: 300),
                                controller: (controller) =>
                                    animateController = controller,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      userName = value;
                                      userError = false;
                                      passError = false;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    // prefixText: editingController.text,
                                    // suffix:
                                    //     Container(child: Text(editingController.text)),
                                    labelText: 'User Name',
                                    //isDense: true,
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  controller: userNameText,
                                )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          (showPasswordField
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: SlideInLeft(
                                            duration:
                                                Duration(milliseconds: 300),
                                            controller: (controller) =>
                                                animateController = controller,
                                            child: TextFormField(
                                              obscureText: _visible,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                              onChanged: (value) {
                                                passWord = value;
                                                setState(() {
                                                  userError = false;
                                                  passError = false;
                                                });
                                              },
                                              controller: passWordText,
                                              decoration: InputDecoration(
                                                labelText: 'Password',
                                                isDense: true,
                                                fillColor: Colors.grey[200],
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    // Based on passwordVisible state choose the icon
                                                    _visible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: Theme.of(context)
                                                        .primaryColorDark,
                                                  ),
                                                  onPressed: () {
                                                    // Update the state i.e. toogle the state of passwordVisible variable
                                                    setState(() {
                                                      _visible = !_visible;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      ),
                                    ])
                              : Container(height: 0)),
                          Container(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CheckerBox(),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: InkWell(
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.cyan,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onTap: () {
                                    /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));*/
                                  },
                                ),
                              ),
                            ],
                          ),
                          (userError
                              ? Container(
                                  child: ListTile(
                                  title: Text(
                                    'Invalid credentials',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  subtitle: Text(
                                    'Please check username and try again',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ))
                              : Container(height: 0)),
                          (passError
                              ? Container(
                                  child: ListTile(
                                  title: Text(
                                    'Invalid credentials',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  subtitle: Text(
                                    'Please check password and try again',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ))
                              : Container(height: 0)),
                          Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: InkWell(
                                  onTap: () async {
                                    /*setState(() {
                          userError = false;
                          passError = false;
                        });*/
                                    var res = await post(
                                        Uri.parse(
                                            'https://imdrm.pilogcloud.com/V10/appUserLogin'),
                                        body: jsonEncode({
                                          "rsUsername": userName, //userName
                                          "rsPassword": passWord, //passWord
                                          "language": "English",
                                        }),
                                        headers: {
                                          'Content-Type': 'application/json',
                                        });
                                    var response = jsonDecode(res.body);
                                    print(response);
                                    if (response['ERROR_MESG'] ==
                                        "Oops! User Does not exist,Please contact Administrator.")
                                      setState(() => userError = true);
                                    else if (response['ERROR_MESG'] ==
                                            "Oops! User ID or Password shoult not be Empty." &&
                                        !showPasswordField)
                                      setState(() => showPasswordField = true);
                                    else if (response['ERROR_MESG'] ==
                                            "Oops! User ID or Password shoult not be Empty." &&
                                        showPasswordField)
                                      setState(() => passError = true);
                                    else {
                                      var login = response['ssUsername'] ?? '';
                                      if (login == 'SASI_MGR') {
                                        /*var userDetails = {
                              'userName': userName,
                              'instance': response['instance'],
                              'plant': response['plant'],
                              'env': response['env'],
                              'orgn': response['orgn'],
                              'roleId': response['roleId'],
                              'locale': response['locale']
                            };*/
                                        print(response);
                                        //print(userDetails);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HomePageScreen(
                                        //                 //userDetails,
                                        //                 )));
                                        String username = userNameText.text;
                                        String password = passWordText.text;
                                        if (username != '' && password != '') {
                                          print('Successfull');
                                          logindata.setBool('login', false);
                                          logindata.setString(
                                              'username', username);
                                          logindata.setString(
                                              'password', password);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePageScreen()));
                                        }

                                        setState(() {
                                          userName = '';
                                          passWord = '';
                                          userError = false;
                                          passError = false;
                                        });
                                      } else
                                        setState(() => userError = true);

                                      /* print("Sign in click");
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SmartSearch())); */
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Color.fromRGBO(11, 74, 153, 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          showPasswordField == true
                                              ? "Login"
                                              : 'Next',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ))),

                          /*GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF8A2387),
                                Color(0xFFE94057),
                                Color(0xFFF27121),
                              ])
                      ),
                    ),
                  ),*/
                        ],
                      ),
                    )))
          ],
        ),
      )),
    );
  }
}

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  bool? isCheck;
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: Colors.blueGrey, // color of tick Mark
              activeColor: Colors.blue,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
              text: "Remember me",
              style:
                  TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
