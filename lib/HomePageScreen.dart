import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:login_app/LoginApp.dart';
import 'package:login_app/SelectedRecords.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FormDataItem.dart';
import 'GeoLocation.dart';

class HomePageScreen extends StatefulWidget {
  /*var userDetails;
  HomePageScreen(this.userDetails);*/

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late SharedPreferences logindata;
  late String username;
  late String password;
  String empty = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
      password = logindata.getString('password')!;
    });
  }

  var FetchDataFARResult;
  bool valueEmpty = true;
  bool isTextVisible = true;
  bool isLoading = true;
  bool isExpanded = false;
  bool isimageCapture = false;
  bool showSelection = false, allSelected = false;
  var result = [];
  final imgPicker = ImagePicker();
  XFile? imageCamera;
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 74, 153, 1),
        // automaticallyImplyLeading: true,
        // backgroundColor: Color(0xff),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 9.0),
        //   child: Image.asset(
        //     'assets/Images/PiLog Logo.png',
        //   ),
        // ),
        actions: [
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: SearchBarAnimation(
              onExpansionComplete: () {
                setState(() {
                  isExpanded = true;
                  isTextVisible = false;
                });
              },
              onCollapseComplete: () {
                setState(() {
                  isExpanded = false;
                  isTextVisible = true;
                });
              },
              durationInMilliSeconds: 400,
              onPressButton: (isOpen) {
                print('done');
              },
              enableBoxBorder: true,
              searchBoxColour: Colors.grey[200],
              searchBoxBorderColour: Colors.blueAccent,
              enableKeyboardFocus: true,
              enableBoxShadow: true,
              isSearchBoxOnRightSide: true,
              buttonWidget: Icon(Icons.search_sharp),
              secondaryButtonWidget: Icon(
                Icons.close,
                color: Colors.grey,
                size: 25,
              ),
              textEditingController: SearchController,
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black45,
              trailingWidget: Icon(
                Icons.search_sharp,
                size: 25,
                color: Colors.blueAccent,
              ),
              onChanged: (value) {
                debugPrint('onFieldSubmitted value $value');

                isTextVisible == false;
                if (value.length < 2 && isTextVisible == false) {
                  value = '';
                  Text('PLS check');
                } else
                  return FetchDataFARAPI(value);
              },
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              var list = <PopupMenuEntry<Object>>[];
              list.add(PopupMenuItem(
                child: Text('Logout'),
                value: 1,
                // onTap: () {

                // },
              ));
              // list.add(PopupMenuItem(
              //   child: Text('Parametric Search'),
              //   value: 2,
              // ));
              return list;
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onSelected: (valuee) {
              // print('$valuee');
              if (valuee == 1) {
                setState(() {
                  logindata.setBool('login', true);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => LoginApp()));
                });
              }
            },
          ),
        ],
      ),
      body:
          //  isTextVisible == true
          //     ? Center(
          //         child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text('Pls Search For Records'),
          //           Image.asset('assets/Images/search.gif'),
          //         ],
          //       ))
          //     :
          Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Center(child: Container()),
                  ...FetchDataFAR(),
                ],
              )),
    );
  }

  FetchDataFARAPI(value) async {
    setState(() {
      isLoading = false;
    });
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "apiReqId": "7B105EDE59C442D585198D501FED3B51",
      "apiReqCols":
          "RECORD_NO,RECORD_TYPE,RECORD_GROUP,UOM,REGION,LOCALE,ERP_NO,INSTANCE,BUSINESS_UNIT,STATUS,CLASS_TERM",
      "apiReqWhereClause": "RECORD_NO LIKE '%$value%'".toUpperCase(),
      "apiReqOrgnId": "C1F5CFB03F2E444DAE78ECCEAD80D27D",
      "apiReqUserId": "AJAY_IDAM_DA",
      "apiRetType": "JSON"
    });
    var response = await post(
      Uri.parse('https://imdrm.pilogcloud.com/V10/getApiRequestResultsData'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      setState(() {});
      try {
        setState(() {
          FetchDataFARResult = jsonDecode(utf8.decode(response.bodyBytes));
          print(FetchDataFARResult);
          isLoading == false;
        });
      } catch (e) {
        print(FetchDataFARResult);
        FetchDataFARResult = null;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  FetchDataFAR() {
    if (FetchDataFARResult == null ||
        FetchDataFARResult['apiDataArray'] == null ||
        FetchDataFARResult['apiDataArray'].length == 0) {
      return [];
    }
    return [
      isLoading == true
          ? CircularProgressIndicator()
          : Row(
              children: [
                ...showSelection
                    ? [
                        Text('Select All'),
                        Checkbox(
                            value: allSelected,
                            onChanged: (val) => setState(() {
                                  allSelected = val == true;
                                  FetchDataFARResult['apiDataArray'] =
                                      FetchDataFARResult['apiDataArray']
                                          .map((result) {
                                    result['selected'] = val == true;
                                    return result;
                                  }).toList();
                                })),
                      ]
                    : [],
                GestureDetector(
                  onTap: () {
                    List filteredValues = FetchDataFARResult["apiDataArray"]
                        .where((v) => v['selected'] == true)
                        .toList();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeoLocation(filteredValues)));
                  },
                  child: Icon(
                    Icons.location_on,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    List filteredValues = FetchDataFARResult["apiDataArray"]
                        .where((v) => v['selected'] == true)
                        .toList();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Center(child: Text('UPLOAD IMAGE')),
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  color: Colors.transparent,
                                  height: 70,
                                  width: 70,
                                  child: Center(
                                    child:
                                        Image.asset('assets/Images/camera.gif'),
                                  ),
                                ),
                                onTap: () async {
                                  imageCamera = await ImagePicker.platform
                                      .getImage(source: ImageSource.camera)
                                      .then((picture) {
                                    return picture
                                        as XFile; // I found this .then necessary
                                  });

                                  if (imageCamera != null) {
                                    imageCamera = (await ImageCropper.platform
                                        .cropImage(
                                            aspectRatioPresets: [
                                          CropAspectRatioPreset.square,
                                          CropAspectRatioPreset.ratio3x2,
                                          CropAspectRatioPreset.original,
                                          CropAspectRatioPreset.ratio4x3,
                                          CropAspectRatioPreset.ratio16x9
                                        ],
                                            uiSettings: [
                                          AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.deepOrange,
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                                  CropAspectRatioPreset
                                                      .original,
                                              lockAspectRatio: false),
                                        ],
                                            sourcePath: imageCamera!.path
                                                .toString())) as XFile?;
                                  }
                                },
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Text(
                                'Click to Capture Image',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add_a_photo_outlined,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      List filteredValues = FetchDataFARResult["apiDataArray"]
                          .where((v) => v['selected'] == true)
                          .toList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SelectedRecords(filteredValues)));
                    },
                    child: Icon(Icons.drafts)),
                Spacer(),
                Text('Toggle Selection'),
                Checkbox(
                    value: showSelection,
                    onChanged: (val) => setState(() => showSelection = val!))
              ],
            ),
      ...FetchDataFARResult["apiDataArray"]
          .map<Card>((Value) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.all(6),
                elevation: 5,
                child: ListTile(
                  trailing: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormDataItem(Value)));
                        },
                        child: Icon(Icons.list_alt_outlined),
                      ),
                      Spacer(),
                    ],
                  ),
                  leading: showSelection
                      ? Checkbox(
                          value: Value['selected'] == true,
                          onChanged: (val) {
                            setState(() => Value['selected'] = val);
                            print(val);
                          },
                        )
                      : null,
                  title: Text(Value["CLASS_TERM"] ?? 'No Class term'),
                  subtitle: Text("\nRecordNo:\n\t" +
                      Value['RECORD_NO'] +
                      "\nStatus:\n\t" +
                      (Value['STATUS'] ?? '-') +
                      // "\nERP_No:\n\t" +
                      // Value['ERP_NO'] +
                      "\nERP_NO:\n\t" +
                      (Value['ERP_NO'] ?? '')),
                ),
              ))
          .toList(),
    ];
  }
}

class ImagePrev extends StatefulWidget {
  const ImagePrev({Key? key}) : super(key: key);

  @override
  State<ImagePrev> createState() => _ImagePrevState();
}

class _ImagePrevState extends State<ImagePrev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
