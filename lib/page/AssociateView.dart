import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hive_associates/assoicateData.dart';
import 'package:project_hive_associates/model/associate.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'associateEdit.dart';

class AssociateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _deleteConfirmation(currentAssociate) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Are you sure?',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You are about to delete ${currentAssociate.name}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('This action cannot be undone'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Log.d('Deleting ${currentAssociate.name}');
                  Provider.of<AssociateData>(context, listen: false)
                      .deleteAssociate(currentAssociate.key);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Navigator.defaultRouteName),
                  );
                },
                child: Text(
                  'DELETE',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Log.d('Cancelling');
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        },
      );
    }

    return Consumer<AssociateData>(builder: (context, associateData, child) {
      Associate currentAssociate = associateData.getActiveAssociate();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          elevation: 16.0,
          title: Text(
            currentAssociate?.name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.create,
              ),
              onPressed: () {
                Log.d("Select to Edit");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AssociateEditPage(
                          currentAssociate: currentAssociate);
                    },
                  ),
                );
              },
              iconSize: 24.0,
              color: Colors.blue,
              tooltip: 'Edit',
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Log.d("Select to Delete");
                _deleteConfirmation(currentAssociate);
              },
              iconSize: 24.0,
              color: Colors.red,
              tooltip: 'Delete',
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 36,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Phone",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        currentAssociate?.phone.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 36,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Age",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        currentAssociate?.age.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 36,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Join Date",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd")
                            .format(currentAssociate?.joinDate),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 36,
                  color: Colors.white54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Senior",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Switch(
                        value: currentAssociate.isSenior,
                        activeTrackColor: Colors.black,
                        onChanged: (bool v){

                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
