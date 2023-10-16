class SalesInvoiceHModel {




 /* "Cust_No TEXT,"
  "Date TEXT,"
  "UserID TEXT,"
  "OrderNo TEXT UNIQUE not null,"
  "hdr_dis_per TEXT,"
  "hdr_dis_value TEXT,"
  
  "Total TEXT,"
  "Net_Total TEXT,"
  "Tax_Total TEXT,"
  "include_Tax TEXT,"
  
  "inovice_type TEXT,"
  "V_OrderNo TEXT,"
  "posted TEXT )"
  */
  String? Cust_No;
  String? Date;
  String? UserID;
  String? OrderNo;
  String? hdr_dis_per;
  String? hdr_dis_value;
  
  String? Total;
  String? Net_Total;
  String? Tax_Total;
  String? include_Tax;
  
  String? inovice_type;
  String? V_OrderNo;
  String? posted;



  SalesInvoiceHModel({
    this.Cust_No,
    this.Date,
    this.UserID,
    this.OrderNo,
    this.hdr_dis_per,
    this.hdr_dis_value,
    this.Total,
    this.Net_Total,
    this.Tax_Total,
    this.include_Tax,
    this.inovice_type,
    this.V_OrderNo,
    this.posted,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory SalesInvoiceHModel.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceHModel(
      Cust_No: map['Cust_No'],
      Date: map['Date'],
      UserID: map['UserID'],
      OrderNo: map['OrderNo'],
      hdr_dis_per: map['hdr_dis_per'],
      hdr_dis_value: map['hdr_dis_value'],
      Total: map['Total'],
      Net_Total: map['Net_Total'],
      Tax_Total: map['Tax_Total'],
      include_Tax: map['include_Tax'],
      inovice_type: map['inovice_type'],
      V_OrderNo: map['V_OrderNo'],
      posted: map['posted'],


      
    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'Cust_No': Cust_No,
      'Date': Date,
      'UserID': UserID,
      'OrderNo': OrderNo,
      'hdr_dis_per': hdr_dis_per,
      'hdr_dis_value': hdr_dis_value,
      'Total': Total, // Convert DateTime to ISO 8601 string
      'Net_Total': Net_Total,
      'Tax_Total': Tax_Total,
      'include_Tax': include_Tax,
      'inovice_type': inovice_type,
      'V_OrderNo': V_OrderNo,
      'posted': posted, // Convert DateTime to ISO 8601 string


     
    };
  }
}