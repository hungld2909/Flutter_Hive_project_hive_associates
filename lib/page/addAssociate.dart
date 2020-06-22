import 'package:flutter/material.dart';
import 'package:project_hive_associates/model/associate.dart';
import 'package:project_hive_associates/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../assoicateData.dart';

class AddAssociatePage extends StatefulWidget {
  @override
  _AddAssociatePageState createState() => _AddAssociatePageState();
}

class _AddAssociatePageState extends State<AddAssociatePage> {
  String name;
  int phone;
  bool senior;
  int age;
  DateTime joined;

  void _addAssociate(context) {
    if (name == null) {
      toastWidget("Give entry a name");
      return;
    }
    if (name.length < 2) {
      toastWidget("Get a longer name");
      return;
    }
    Provider.of<AssociateData>(context, listen: false).addAssociate(
      Associate(
        name: name,
        age: age ?? 0,
        phone: phone ?? 0,
        isSenior: senior ?? false,
        joinDate: joined ?? DateTime.now(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
        title: Text(
          "Add Associate",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 24,
            color: Colors.blue,
            tooltip: "Save",
            onPressed: () {
              _addAssociate(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Name",
              ),
              onChanged: (v) {
                setState(() {
                  name = v;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Phone",
              ),
              onChanged: (v) {
                setState(() {
                  phone = int.parse(v);
                });
              },
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                hintText: "Age",
              ),
              onChanged: (v) {
                setState(() {
                  age = int.parse(v);
                });
              },
            ),
            Row(
              children: <Widget>[
                Text(
                  "Is senior",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Switch(
                    activeTrackColor: Colors.black,
                    activeColor: Colors.blue,
                    value: senior ?? false,
                    onChanged: (v) {
                      setState(() {
                        senior = v;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Join Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: "Tap to open the data picker",
                  onPressed: () async {
                    final DateTime d = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2016),
                      lastDate: DateTime(2100),
                    );
                    if (d != null)
                      setState(() {
                        joined = d;
                      });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
