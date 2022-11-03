import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class SelectedRecords extends StatefulWidget {
  List selectedvalue = [];
  SelectedRecords(this.selectedvalue, {Key? key}) : super(key: key);

  @override
  State<SelectedRecords> createState() => _SelectedRecordsState();
}

class _SelectedRecordsState extends State<SelectedRecords> {
  void initState() {
    super.initState();
    print(widget.selectedvalue.toString());
    openBox();
  }

  late Box box;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('DataBox');
    return;
  }

  List<Card> data = [];
  var RecordDataFARResult;
  savedata() async {
    await openBox();
    box.put('DraftRecord', widget.selectedvalue.toList());
  }

  readdata() async {
    await openBox();
    var read = box.get('DraftRecord');
    print(read.toString());
  }

  @override
  Widget build(BuildContext context) {
    // var data = widget.selectedvalue.map<List>((e) {
    //   List val = e;
    //   print(val);
    //   return val;
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('LOCAL DRAFT'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await savedata();
                setState(() {
                  if (box.get('DraftRecord') == Null) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Please add record'),
                            ));
                  } else {
                    box.add(widget.selectedvalue.toList());
                  }
                });
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                await readdata();
              },
              icon: Icon(Icons.read_more)),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: widget.selectedvalue.length,
            itemBuilder: ((context, index) => Card(
                  elevation: 10,
                  child: ListTile(
                    title: Text('CLASSTERM :  ' +
                            widget.selectedvalue[index]['CLASS_TERM'] ??
                        ''),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('UOM :  ' + widget.selectedvalue[index]['UOM']),
                        Text('RECORD NO :  ' +
                            widget.selectedvalue[index]['RECORD_NO']),
                        Text('STATUS :  ' +
                            widget.selectedvalue[index]['STATUS']),
                        Text('ERP NO :  ' +
                            widget.selectedvalue[index]['ERP_NO']),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  // RecordDataFARAPI(value) async {
  //   setState(() {});
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = json.encode({
  //     "apiReqId": "7B105EDE59C442D585198D501FED3B51",
  //     "apiReqCols":
  //         "RECORD_NO,RECORD_TYPE,RECORD_GROUP,UOM,REGION,LOCALE,ERP_NO,INSTANCE,BUSINESS_UNIT,STATUS,CLASS_TERM",
  //     "apiReqWhereClause": "RECORD_NO LIKE '%$value%'".toUpperCase(),
  //     "apiReqOrgnId": "C1F5CFB03F2E444DAE78ECCEAD80D27D",
  //     "apiReqUserId": "AJAY_IDAM_DA",
  //     "apiRetType": "JSON"
  //   });
  //   var response = await post(
  //     Uri.parse('https://imdrm.pilogcloud.com/V10/getApiRequestResultsData'),
  //     headers: headers,
  //     body: body,
  //   );

  //   if (response.statusCode == 200) {
  //     setState(() {});
  //     try {
  //       setState(() {
  //         RecordDataFARResult = jsonDecode(utf8.decode(response.bodyBytes));
  //         print(RecordDataFARResult);
  //       });
  //     } catch (e) {
  //       print(RecordDataFARResult);
  //       RecordDataFARResult = null;
  //     }
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
