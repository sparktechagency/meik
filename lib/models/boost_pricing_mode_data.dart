class BoostPricingModelData {
  int? days;
  dynamic cost;
  String? currency;

  BoostPricingModelData({this.days, this.cost, this.currency});

  BoostPricingModelData.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    cost = json['cost'];
    currency = json['currency'];
  }
}
