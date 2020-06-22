import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_hive_associates/assoicateData.dart';
import 'package:project_hive_associates/model/associate.dart';
import 'package:project_hive_associates/page/addAssociate.dart';
import 'package:project_hive_associates/page/associateList.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() {
  Hive.registerAdapter(AssociateAdapter());
  runApp(AssociateApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

class AssociateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssociateData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Associates",
        theme: ThemeData(
          primaryColor: Colors.lightGreenAccent,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => FutureBuilder(
                future: _initHive(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.error != null){
                      print(snapshot.error);
                      return Scaffold(
                        body: Center(
                          child: Text("Error establishing connection to hive"),
                        ),
                      );
                      
                    }else{
                      return AssociateListPage();
                    }
                   
                  } else return Scaffold(

                    );
                },
              ),
              "/AddAssociatePage":(context) => AddAssociatePage()
        },
      ),
    );
  }
}
