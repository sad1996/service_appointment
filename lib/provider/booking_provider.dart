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
  double selectedMiles = 10;
  ModelDefault selectedAdvisor =
      ModelDefault('Any Service Advisor', 'assets/images/avatars/avtr_any.png');
  TransportType selectedTransportType;
  DateTime selectedDate;
  String selectedTimeSlot;
  List<ServiceModel> addedServiceList = List();

  String get cartCount => addedServiceList.length.toString();

  String get cartTotal => '\$' + getCartTotal().toStringAsFixed(2);

  List<ServiceModel> primaryServices = [
    ServiceModel(
      id: 1,
      serviceTitle: 'Factory Required',
      serviceCharge: 91.95,
      items: 3,
      serviceAsset: 'assets/images/factory_required.png',
    ),
    ServiceModel(
      id: 1,
      serviceTitle: 'Value Preferred',
      serviceCharge: 110.00,
      items: 5,
      serviceAsset: 'assets/images/value_preferred.png',
    ),
    ServiceModel(
      id: 1,
      serviceTitle: 'Premium Preferred',
      serviceCharge: 180.00,
      items: 9,
      serviceAsset: 'assets/images/premium_preferred.png',
    ),
  ];

  ServiceModel radioValue(ServiceModel model) => addedServiceList.contains(model) ? model : null;

  checkAndInsert(ServiceModel value){
    primaryServices.forEach((item){
      if(addedServiceList.contains(item))
        addedServiceList.remove(item);
    });
    addedServiceList.add(value);
    notifyListeners();
  }

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

  setDefaultAdvisor() {
    selectedAdvisor = ModelDefault(
        'Any Service Advisor', 'assets/images/avatars/avtr_any.png');
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
    if (addedServiceList.contains(value)) {
      addedServiceList.remove(value);
      print('coming here');
    } else {
      if (value.groupId != null)
        addedServiceList.forEach((service) {
          if (service.groupId == value.groupId) {
            addedServiceList.remove(service);
            print('found here');
          }
        });
      addedServiceList.add(value);
    }
    notifyListeners();
  }

  clearAddedServices() {
    addedServiceList.clear();
    notifyListeners();
  }

  setMiles(double value) {
    selectedMiles = value;
    notifyListeners();
  }

  clearAll() {
    setDefaultAdvisor();
    selectedTransportType = null;
    selectedDate = null;
    selectedTimeSlot = null;
    selectedMake = null;
    selectedYear = null;
    selectedVehicleModel = null;
    firstTextController.clear();
    clearAddedServices();
  }
}
