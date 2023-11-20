
class Supply_D_Model {
  String? Unite;
  String? no;
  String? Price;
  String? Qty;
  String? Total;


  Supply_D_Model(
   {
    required this.Unite,
    required this.no,
    required this.Price,
    required this.Qty,
    required this.Total,
   }
   );


  Supply_D_Model.fromMap(Map<dynamic, dynamic> res)
      :
        Unite = res["Unite"].toString(),
        no = res["no"].toString(),
        Price = res["Price"].toString(),
        Qty = res["Qty"].toString(),
        Total = res["Total"].toString();


  Map<String, Object?> toMap() {
    return {
      'Unite': Unite,
      'no': no,
      'Price': Price,
      'Qty': Qty,
      'Total': Total,
    };
  }


  Supply_D_Model.fromJson(Map<String, dynamic> json) {
    Unite = json['Unite'];
    no = json['no'];
    Price = json['Price'];
    Qty = json['Qty'];
    Total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Unite': Unite,
      'no': no,
      'Price': Price,
      'Qty': Qty,
      'Total': Total,
      // Add other fields as needed
    };
  }

}
