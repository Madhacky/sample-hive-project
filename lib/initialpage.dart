import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Initialpage extends StatefulWidget {
  const Initialpage({Key? key}) : super(key: key);

  @override
  State<Initialpage> createState() => _InitialpageState();
}

class _InitialpageState extends State<Initialpage> {
  var FetchData;
  @override
  void initState() {
    super.initState();
    FetchDataFARAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ...FetchDataFAR(),
            ],
          )),
    );
  }

  FetchDataFARAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "apiReqId": "7B105EDE59C442D585198D501FED3B51",
      "apiReqCols":
          "RECORD_NO,RECORD_TYPE,RECORD_GROUP,UOM,REGION,LOCALE,ERP_NO,INSTANCE,BUSINESS_UNIT,STATUS,CLASS_TERM,ABBREVIATION,BU_DH_CUST_COL34,BU_DH_CUST_COL33",
      "apiReqWhereClause": "RECORD_NO LIKE '%%'",
      "apiReqOrgnId": "C1F5CFB03F2E444DAE78ECCEAD80D27D",
      "apiReqUserId": "SASI_MGR",
      "apiRetType": "JSON"
    });
    var response = await post(
      Uri.parse('https://imdrm.pilogcloud.com/V10/getApiRequestResultsData'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      try {
        setState(() {
          FetchData = jsonDecode(utf8.decode(response.bodyBytes));
          print(FetchData);
        });
      } catch (e) {
        print(FetchData);
        FetchData = null;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  FetchDataFAR() {
    if (FetchData == null ||
        FetchData['apiDataArray'] == null ||
        FetchData['apiDataArray'].length == 0) {
      return [];
    }
    return [
      ...FetchData["apiDataArray"]
          .map<Card>((Value) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.all(6),
                elevation: 5,
                child: ListTile(
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
