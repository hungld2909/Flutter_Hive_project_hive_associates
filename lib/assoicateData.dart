import 'package:flutter/material.dart';
import 'package:project_hive_associates/model/associate.dart';
import 'package:hive/hive.dart';
import 'package:project_hive_associates/utils.dart';

class AssociateData extends ChangeNotifier {
  static const String _boxName = "associateBox";
  List<Associate> _associate = [];

  Associate _activeAssociate;

  void getAssociates() async {
    var box = await Hive.openBox<Associate>(_boxName);
    //! tất cả dữ liệu được lưu trong OpenBox.
    // var box = await Hive.openBox<E>('testBox');
  // var box = await Hive.openBox('testBox');
  // box.put('name', 'David');
  // print('Name: ${box.get('name')}'); 
  //! when print data : name: David
    _associate = box.values.toList();
    notifyListeners();
  }

  Associate getAssociate(index) {
    return _associate[index];
  }

 
  void addAssociate(Associate associate) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.add(associate);

    _associate = box.values.toList();

    notifyListeners();
  }

void deleteAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.delete(key);

    _associate = box.values.toList();

    Log.i("Deleted member with key" + key.toString());

    notifyListeners();
  }

  void editAssociate({Associate associate, int associateKey}) async {
    var box = await Hive.openBox<Associate>(_boxName);
    await box.put(associateKey, associate);
    _associate = box.values.toList();
    _activeAssociate = box.get(associateKey);
    Log.i("Edited" + associate.name);
    notifyListeners();
  }

  void setActiveAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);
    _activeAssociate = box.get(key);
    notifyListeners();
  }

  Associate getActiveAssociate() {
    return _activeAssociate;
  }

  int get associateCount {
    return _associate.length;
  }
}
