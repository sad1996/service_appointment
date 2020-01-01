class ServiceModel {
  final String serviceTitle;
  final String serviceSubTitle;
  final String serviceAsset;
  final double serviceCharge;
  final int items;

  String get serviceCost => '\$' + serviceCharge.toStringAsFixed(2);

  ServiceModel({this.serviceTitle, this.serviceSubTitle, this.serviceAsset, this.serviceCharge, this.items});
}
