import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:service_appointment/model/model_default.dart';
import 'package:service_appointment/model/service.dart';
import 'package:vibrate/vibrate.dart';

import '../fourth_page.dart';

class BookingProvider with ChangeNotifier {
  BookingProvider() {
    init();
  }

  init() async {
    canVibrate = kIsWeb ? false : await Vibrate.canVibrate;
    notifyListeners();
  }

  TextEditingController firstTextController = TextEditingController();
  bool canVibrate;
  ModelDefault selectedMake;
  int selectedYear;
  ModelDefault selectedVehicleModel;
  String selectedMiles = '15k';
  ModelDefault selectedAdvisor;
  TransportType selectedTransportType;
  DateTime selectedDate;
  String selectedTimeSlot;
  List<ServiceModel> addedServiceList = List();

  String get cartCount => addedServiceList.length.toString();

  String get cartTotal => '\$' + getCartTotal().toStringAsFixed(2);

  double getCartTotal() {
    double total = 0;
    if (addedServiceList.length > 0)
      addedServiceList.forEach((item) => total += item.serviceCharge);
    return total;
  }

  setMake(ModelDefault value) {
    selectedMake = value;
    notifyListeners();
  }

  setYear(int value) {
    selectedYear = value;
    notifyListeners();
  }

  setVehicleModel(ModelDefault value) {
    selectedVehicleModel = value;
    notifyListeners();
  }

  setAdvisor(ModelDefault value) {
    selectedAdvisor = value;
    notifyListeners();
  }

  setTransportType(TransportType value) {
    selectedTransportType = value;
    notifyListeners();
  }

  setDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  setTimeSlot(String value) {
    selectedTimeSlot = value;
    notifyListeners();
  }

  addOrRemoveServiceToCart(ServiceModel value) {
    if (addedServiceList.contains(value))
      addedServiceList.remove(value);
    else
      addedServiceList.add(value);
    notifyListeners();
  }

  clearAddedServices() {
    addedServiceList.clear();
    notifyListeners();
  }

  setMiles(String value) {
    selectedMiles = value;
    notifyListeners();
  }
}
