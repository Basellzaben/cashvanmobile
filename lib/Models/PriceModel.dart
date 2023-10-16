class PriceModel {
  String? UnitName;
  String? Unitno;
  String? price;
  String? bounce;
  String? dis;
  String? Operand;



  PriceModel({
    required this.Unitno,
    required this.UnitName,
    required this.price,
    required this.bounce,
    required this.dis,
    required this.Operand,

  }
  );

  PriceModel.fromMap(Map<dynamic, dynamic> res)
      : Unitno = res["Unitno"].toString(),
        UnitName = res["UnitName"].toString(),
        price = res["price"].toString(),
        bounce = res["bounce"].toString(),
        dis = res["dis"].toString(),
  Operand = res["Operand"].toString();

  Map<String, Object?> toMap() {
    return {
      'Unitno': Unitno,
      'UnitName': UnitName,
      'price': price,
      'bounce': bounce,
      'dis': dis,
      'Operand': Operand,

    };
  }

  PriceModel.fromJson(Map<String, dynamic> json) {
    Unitno = json['unitno'];
    UnitName = json['unitName'];
    price = json['price'];
    bounce = json['bounce'];
    dis = json['dis'];
    Operand = json['Operand'];

  }


}
