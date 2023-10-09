class ItemsCartModel {
  String? Item_No;
  String? Item_Name;
  String? Ename;
  String? Unit;
  double? Price;
  double? qt;


  ItemsCartModel({
    required this.Item_No,
    required this.Item_Name,
    required this.Ename,
    required this.Unit,
    required this.Price,
    required this.qt,

  });
  factory ItemsCartModel.fromMap(Map<String, dynamic> map) {
    return ItemsCartModel(
      Item_No: map['Item_No'],
      Item_Name: map['Item_Name'],
      Ename: map['Ename'],
      Unit: map['Unit'],
      Price: map['Price'],
      qt: map['qt'],

    );
  }

  // Convert to a Map
  Map<String, dynamic> toMap() {
    return {
      'item_No': Item_No,
      'Item_Name': Item_Name,
      'Ename': Ename,
      'Unit': Unit,
      'Price': Price,
      'qt': qt,
    };
  }
  factory ItemsCartModel.fromJson(Map<String, dynamic> json) {
    return ItemsCartModel(
      Item_No: json['item_No'],
      Item_Name: json['item_Name'],
      Ename: json['ename'],
      Unit: json['unit'],
      Price: json['price'],
      qt: json['qt'],

    );
  }
}