import 'package:flutter/material.dart';
import 'package:project_hive_associates/assoicateData.dart';
import 'package:project_hive_associates/widgets/assoicateList.dart';
import 'package:provider/provider.dart';

class AssociateListPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Provider.of<AssociateData>(context, listen: false).getActiveAssociate();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Associates",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: AssociateList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        tooltip: "Add",
        onPressed: () {
          Navigator.pushNamed(context, '/AddAssociatePage');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
