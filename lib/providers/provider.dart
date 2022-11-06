import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  TextEditingController roleController = TextEditingController();
  int index = 0;
  bool isEndTheGame = false;

  onPressed() {
    if (index < list.length - 1) {
      index++;
    } else {
      isEndTheGame = true;
    }
    notifyListeners();
  }

  Map<String, int> roles = {
    '_': 0,
    'مافيا': 2,
    'زعيم المافيا': 1,
    'مواطن': 5,
    'دكتور': 1,
    'قاتل متسلسل': 0,
    'محقق': 1,
    'زعيم المواطنين': 1,
  };

  List list = [];

  void addToRoles(map) {
    roles.addAll(map);
    number = 1;
    roleController.clear();
    roles.forEach((key, value) {
      print("$key - $value");
    });
    notifyListeners();
  }

  void plus(key) {
    roles.update(key, (value) => value + 1);
    notifyListeners();
  }

  void minus(key, number) {
    if (number != 0) {
      roles.update(key, (value) => value - 1);
    }
    notifyListeners();
  }

  void plusNew() {
    number++;
    notifyListeners();
  }

  void minusNew() {
    if (number != 1) {
      number--;
    }
    notifyListeners();
  }

  bool callback = false;

  int number = 1;

  void check(role) {
    if (role.isNotEmpty) {
      callback = true;
    } else {
      callback = false;
    }
    notifyListeners();
  }
}
