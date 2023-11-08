class ReturnedHlModel {


  String? Net_Total;
  String? Cust_No;
  String? OrderNo;
  String? Date;
  String? bounce_Total;
  String? Tax_Total;
  String? include_Tax;
  String? CashCustNm;
  String? Total;
  String? UserID;
  String? V_OrderNo;
  String? return_type;
  String? bill;





  ReturnedHlModel({
    this.Net_Total,
    this.Cust_No,
    this.OrderNo,
    this.Date,
    this.bounce_Total,
    this.CashCustNm,
    this.V_OrderNo,
    this.Tax_Total,
    this.bill,

    this.include_Tax,
    this.return_type,
    this.Total,
    this.UserID,
  });

  factory ReturnedHlModel.fromJson(Map<String?, dynamic> json) {
    return ReturnedHlModel(
      Net_Total: json['Net_Total'],
      Cust_No: json['Cust_No'],
      OrderNo: json['OrderNo'],
      Date: json['Date'],
      bounce_Total: json['bounce_Total'],
      CashCustNm: json['CashCustNm'],
      V_OrderNo: json['V_OrderNo'],
      Tax_Total: json['Tax_Total'],

      bill: json['bill'],


      include_Tax: json['include_Tax'],
      return_type: json['return_type'],
      Total: json['Total'],
      UserID: json['UserID'],
      
    );
  }

  // Factory constructor to create a ManLogTransModel object from a map
  factory ReturnedHlModel.fromMap(Map<String, dynamic> map) {
    return ReturnedHlModel(
      Net_Total: map['Net_Total'],
      Cust_No: map['Cust_No'],
      OrderNo: map['OrderNo'],
      Date: map['Date'],
      bounce_Total: map['bounce_Total'],
      CashCustNm: map['CashCustNm'],
      V_OrderNo: map['V_OrderNo'],
      Tax_Total: map['Tax_Total'],

      bill: map['bill'],


      include_Tax: map['include_Tax'],
      return_type: map['return_type'],
      Total: map['Total'],
      UserID: map['UserID'],
    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'Net_Total': Net_Total,
      'Cust_No': Cust_No,
      'OrderNo': OrderNo,
      'Date': Date,
      'bounce_Total': bounce_Total,
      'CashCustNm': CashCustNm,
      'V_OrderNo': V_OrderNo,
      'Tax_Total': Tax_Total,

      'bill': bill,


      'include_Tax': include_Tax,
      'return_type': return_type,
      'Total': Total,
      'UserID': UserID,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Net_Total'] = this.Net_Total.toString();
    data['Cust_No'] = this.Cust_No.toString();
    data['OrderNo'] = this.OrderNo.toString();
    data['Date'] = this.Date.toString();
    data['bounce_Total'] = this.bounce_Total.toString();
    data['CashCustNm'] = this.CashCustNm.toString();
    data['V_OrderNo'] = this.V_OrderNo.toString();
    data['Tax_Total'] = this.Tax_Total.toString();
    data['bill'] = this.bill.toString();
    data['include_Tax'] = this.include_Tax.toString();
    data['return_type'] = this.return_type.toString();
    data['Total'] = this.Total.toString();
    data['UserID'] = this.UserID.toString();

    return data;
  }
}
