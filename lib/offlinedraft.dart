import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class OfflineDraft extends StatefulWidget {
  OfflineDraft(box, {Key? key}) : super(key: key);

  @override
  State<OfflineDraft> createState() => _OfflineDraftState();
}

class _OfflineDraftState extends State<OfflineDraft> {
  void initState() {
    super.initState();
    readdata();
    openBox();
  }

  bool isdata = false;
  late Box box;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('DataBox');
    return;
  }

  var data;
  readdata() async {
    await openBox();
    var read = box.get('DraftRecord');
    setState(() {
      data = read;
      isdata = true;
    });
    print(read);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Records'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: isdata == true
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) => Card(
                      elevation: 10,
                      child: ListTile(
                        title: Text(
                            'CLASSTERM :  ' + data[index]['CLASS_TERM'] ?? ''),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('UOM :  ' + data[index]['UOM']),
                            Text('RECORD NO :  ' + data[index]['RECORD_NO']),
                            Text('STATUS :  ' + data[index]['STATUS']),
                            Text('ERP NO :  ' + data[index]['ERP_NO']),
                          ],
                        ),
                      ),
                    )))
            : CircularProgressIndicator(),

        //  ListView.builder(
        //     // itemCount: Mydata.length,
        //     // itemCount: data.length,
        //     itemBuilder: ((context, index) => Card(
        //           child: ListTile(
        //             title: Text('CLASSTERM :  ' + data[index]['CLASS_TERM']),
        //             subtitle: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 Text('UOM :  ' + data[index]['UOM']),
        //                 Text('RECORD NO :  ' + data[index]['RECORD_NO']),
        //                 Text('STATUS :  ' + data[index]['STATUS']),
        //                 Text('ERP NO :  ' + data[index]['ERP_NO']),
        //               ],
        //             ),
        //           ),
        //         )))
      ),
    );
  }

  // List<Card> Record() {
  //   if (data.length == 0) {
  //     return [
  //       Card(
  //         child: Text('no data'),
  //       )
  //     ];
  //   } else
  //     return data
  //         .map((value) => Card(
  //               child: ListTile(
  //                 title: Text(value['UOM']),
  //               ),
  //             ))
  //         .toList();
  // }
}
