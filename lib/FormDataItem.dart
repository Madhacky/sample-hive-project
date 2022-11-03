import 'package:flutter/material.dart';

class FormDataItem extends StatefulWidget {
  var FetchData;
  FormDataItem(this.FetchData);

  @override
  State<FormDataItem> createState() => _FormDataItemState();
}

class _FormDataItemState extends State<FormDataItem> {
  TextEditingController Classtermcontroller = TextEditingController();
  TextEditingController RecordNocontroller = TextEditingController();
  TextEditingController RecordTypecontroller = TextEditingController();
  TextEditingController RecordGroupcontroller = TextEditingController();
  TextEditingController Uomcontroller = TextEditingController();
  TextEditingController Regioncontroller = TextEditingController();
  TextEditingController Localecontroller = TextEditingController();
  TextEditingController ErpNocontroller = TextEditingController();
  TextEditingController Instancecontroller = TextEditingController();
  TextEditingController BusinessUnitcontroller = TextEditingController();
  TextEditingController Statuscontroller = TextEditingController();
  void initState() {
    super.initState();
    Classtermcontroller.text = widget.FetchData['CLASS_TERM'].toString();
    RecordNocontroller.text = widget.FetchData['RECORD_NO'].toString();
    RecordTypecontroller.text = widget.FetchData['RECORD_TYPE'].toString();
    RecordGroupcontroller.text = widget.FetchData['RECORD_GROUP'].toString();
    Uomcontroller.text = widget.FetchData['UOM'].toString();
    Regioncontroller.text = widget.FetchData['REGION'].toString();
    Localecontroller.text = widget.FetchData['LOCALE'].toString();
    ErpNocontroller.text = widget.FetchData['ERP_NO'].toString();
    Instancecontroller.text = widget.FetchData['INSTANCE'].toString();
    BusinessUnitcontroller.text = widget.FetchData['BUSINESS_UNIT'].toString();
    Statuscontroller.text = widget.FetchData['STATUS'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: RecordGroupcontroller,
                  decoration: InputDecoration(
                      label: Text('Record Group'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: RecordNocontroller,
                  decoration: InputDecoration(
                      label: Text('Record Number'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  controller: RecordTypecontroller,
                  decoration: InputDecoration(
                      label: Text('Record Type'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: Regioncontroller,
                  decoration: InputDecoration(
                      label: Text('Region'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: Instancecontroller,
                  decoration: InputDecoration(
                      label: Text('Instance'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: BusinessUnitcontroller,
                  decoration: InputDecoration(
                      label: Text('Business Unit'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: Classtermcontroller,
                  decoration: InputDecoration(
                      label: Text('Class Term'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: Uomcontroller,
                  decoration: InputDecoration(
                      label: Text('Uom'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: Localecontroller,
                  decoration: InputDecoration(
                      label: Text('Locale'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: ErpNocontroller,
                  decoration: InputDecoration(
                      label: Text('Erp No'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: Statuscontroller,
                  decoration: InputDecoration(
                      label: Text('Status'),
                      isDense: true,
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text('UPDATE'))
        ]),
      ),
    );
  }
}
