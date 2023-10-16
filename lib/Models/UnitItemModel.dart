class UnitItemModel {
  String? item_no = "";
  String? barcode = "";
  String? unitno = "";
  String? Operand = "";
  String? price = "";
  String? Max = "";
  String? Min = "";

  UnitItemModel({
    required this.item_no,
    required this.price,
    required this.Operand,
    required this.Max,
    required this.Min,
    required this.barcode,
    required this.unitno
  });

  UnitItemModel.fromMap(Map<dynamic, dynamic> res)
      : item_no = res["item_no"].toString(),
        price = res["price"].toString(),
        Operand = res["Operand"].toString(),
        Max = res["Max"].toString(),
        Min = res["Min"].toString(),
        barcode = res["barcode"].toString(),
        unitno = res["unitno"].toString();

  Map<String, Object?> toMap() {
    return {
      'item_no': item_no,
      'price': price,
      'Operand': Operand,
      'Max': Max,
      'Min': Min,
      'barcode': barcode,
      'unitno': unitno,
    };
  }

  UnitItemModel.fromJson(Map<String, dynamic> json) {
    item_no = json['item_no'];
    price = json['price'];
    Operand = json['operand'];
    Max = json['max'];
    Min = json['min'];
    barcode = json['barcode'];
    unitno = json['unitno'];
  }


}
