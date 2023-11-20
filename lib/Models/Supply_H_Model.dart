
class Supply_H_Model {
  String? CustNo;
  String? OrderNo;
  String? UserId;



  Supply_H_Model({
    required this.CustNo,
    required this.OrderNo,
    required this.UserId,
  }
      );

  Supply_H_Model.fromMap(Map<dynamic, dynamic> res)
      : CustNo = res["CustNo"].toString(),
        OrderNo = res["OrderNo"].toString(),
        UserId = res["UserId"].toString();

  Map<String, Object?> toMap() {
    return {
      'CustNo': CustNo,
      'OrderNo': OrderNo,
      'UserId': UserId,

    };
  }

  Supply_H_Model.fromJson(Map<String, dynamic> json) {
    CustNo = json['CustNo'];
    OrderNo = json['OrderNo'];
    UserId = json['UserId'];

  }


  Map<String, dynamic> toJson() {
    return {
      'CustNo': CustNo,
      'OrderNo': OrderNo,
      'UserId': UserId,
      // Add other fields as needed
    };
  }

}
