import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/save_load_images.dart';

class HomeScreenState with ChangeNotifier {
  HomeScreenState(User user) {
    init(user);
    notifyListeners();
  }

  void init(User user) async {
    loggedUser = user;
    getVehicles();
    loading = false;
    notifyListeners();
  }

  late User loggedUser;
  bool loading = true;

  User get user => loggedUser;

  final vehicleList = <Vehicle>[];

  Future<void> getVehicles() async {
    final result = await VehiclesTableController()
        .selectByDealership(loggedUser.dealershipId);

    result.removeWhere((element) => element.isSold == true);

    vehicleList.clear();
    vehicleList.addAll(result);

    notifyListeners();
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }
}
