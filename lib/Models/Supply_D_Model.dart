
class Supply_D_Model {
  String? Unit;
  String? ItemNo;
  String? Price;
  String? Qty;
  String? Total;


  Supply_D_Model(
   {
    required this.Unit,
    required this.ItemNo,
    required this.Price,
    required this.Qty,
    required this.Total,
   }
   );


  Supply_D_Model.fromMap(Map<dynamic, dynamic> res)
      :
        Unit = res["Unit"].toString(),
        ItemNo = res["ItemNo"].toString(),
        Price = res["Price"].toString(),
        Qty = res["Qty"].toString(),
        Total = res["Total"].toString();


  Map<String, Object?> toMap() {
    return {
      'Unit': Unit,
      'ItemNo': ItemNo,
      'Price': Price,
      'Qty': Qty,
      'Total': Total,
    };
  }


  Supply_D_Model.fromJson(Map<String, dynamic> json) {
    Unit = json['Unit'];
    ItemNo = json['ItemNo'];
    Price = json['Price'];
    Qty = json['Qty'];
    Total = json['Total'];
  }



}
