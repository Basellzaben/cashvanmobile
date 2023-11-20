class StockModel {

  String? TransNo;
  String? TransDate;
  String? CustId;
  String? ManId;
  String? ItemNo;
  String? Qty;
  String? OrderQty;
  String? ExpiryDate;
  String? VisitOrderNo;
  String? unit;
  String? posted;


  String? unitname;
  String? itemname;
  String? customername;


  StockModel({
    this.TransNo,
    this.TransDate,
    this.CustId,
    this.ManId,
    this.ItemNo,
    this.Qty,
    this.OrderQty,
    this.ExpiryDate,
    this.VisitOrderNo,
    this.unit,
    this.posted,

    this.unitname,
    this.itemname,
    this.customername,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(

      TransNo: map['TransNo'],
      TransDate: map['TransDate'],
      CustId: map['CustId'],
      ManId: map['ManId'],
      ItemNo: map['ItemNo'],
      Qty: map['Qty'],
      OrderQty: map['OrderQty'],
      ExpiryDate: map['ExpiryDate'],
      VisitOrderNo: map['VisitOrderNo'],
        unit: map['unit'],
      posted: map['posted'],

      unitname: map['unitname'],
      itemname: map['itemname'],
      customername: map['customername'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'TransNo': TransNo,
      'TransDate': TransDate, // Convert DateTime to ISO 8601 string
      'CustId': CustId,
      'ManId': ManId,
      'ItemNo': ItemNo,
      'Qty': Qty,
      'OrderQty': OrderQty,
      'ExpiryDate': ExpiryDate,
      'VisitOrderNo': VisitOrderNo,
      'unit': unit,
      'posted': posted,


      'unitname': unitname,
      'itemname': itemname,
      'customername': customername,
    };
  }

  StockModel.fromJson(Map<String, dynamic> json) {
    TransNo = json['TransNo'];
    TransDate = json['TransDate'];
    CustId = json['CustId'];
    ManId = json['ManId'];
    ItemNo = json['ItemNo'];
    Qty = json['bonus'];
    OrderQty = json['OrderQty'];
    ExpiryDate = json['ExpiryDate'];
    VisitOrderNo = json['VisitOrderNo'];
    unit = json['unit'];
    posted = json['posted'];

    unitname = json['unitname'];
    itemname = json['itemname'];
    customername = json['customername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransNo'] = this.TransNo;
    data['TransDate'] = this.TransDate;
    data['CustId'] = this.CustId;
    data['ManId'] = this.ManId;
    data['ItemNo'] = this.ItemNo;
    data['Qty'] = this.Qty;
    data['OrderQty'] = this.OrderQty;
    data['ExpiryDate'] = this.ExpiryDate;
    data['VisitOrderNo'] = this.VisitOrderNo;
    data['unit'] = this.unit;
    data['posted'] = this.posted;

    data['unitname'] = this.unitname;
    data['itemname'] = this.itemname;
    data['customername'] = this.customername;

    return data;
  }


}
