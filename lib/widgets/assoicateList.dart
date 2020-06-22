import 'package:flutter/material.dart';
import 'package:project_hive_associates/assoicateData.dart';
import 'package:provider/provider.dart';

import 'assoicateTile.dart';


class AssociateList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AssociateTile (
          tileIndex:index,
        );
      },
      itemCount: Provider.of<AssociateData>(context).associateCount,
      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
    );
  }
}
