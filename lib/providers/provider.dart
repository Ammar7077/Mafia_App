import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyProvider extends ChangeNotifier {
  TextEditingController roleController = TextEditingController();
  bool isPause = true;
  int duration = 60;
  CountDownController timerController = CountDownController();
  timerClicked() {
    if (isPause) {
      isPause = false;
      timerController.resume();
    } else {
      isPause = true;
      timerController.pause();
    }
    notifyListeners();
  }

  bool isTimeComplete = false;
  int index = 0;
  bool isEndTheGame = false;
  bool isCardHidden = false;

  onPressed() {
    if (!toggler) {
      toggler = true;
      notifyListeners();
    }
    if (index < list.length - 1) {
      isCardFlipped = false;
      index++;
    } else if (!isEndTheGame && !isCardHidden) {
      isCardFlipped = true;
      isCardHidden = !isCardHidden;
    } else if (!isEndTheGame && isCardHidden) {
      isEndTheGame = true;
    }
    notifyListeners();
  }

  Map<String, int> roles = {
    '_': 0,
    'مافيا': 2,
    'زعيم المافيا': 0,
    'مواطن': 4,
    'زعيم المواطنين': 1,
    'دكتور': 0,
    'قاتل متسلسل': 0,
    'محقق': 0,
  };

  List list = [];

  void addToRoles(map) {
    roles.addAll(map);
    number = 1;
    roleController.clear();
    roles.forEach((key, value) {
      log("$key - $value");
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

  bool toggler = true;
  bool isCardFlipped = false;
  onFlipCardPressed() {
    toggler = !toggler;
    isCardFlipped = true;
    notifyListeners();
  }
}
