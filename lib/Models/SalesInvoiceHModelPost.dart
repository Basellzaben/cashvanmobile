class SalesInvoiceHModelPost {


 double? Net_Total	;
 double? hdr_dis_value ;
 double? Cust_No      ;
 int? OrderNo     ;
 String? Date		  ;
 double? bounce_Total   ;
 double? hdr_dis_per    ;
 double? disc_Total     ;
 double? Tax_Total     ;
 int? include_Tax   ;
   int?   inovice_type   ;
 String? CashCustNm	   ;
 double? Total         ;
 int? UserID       ;
 double?   V_OrderNo     ;
 String?  OrderDesc    ;





 SalesInvoiceHModelPost({
    this.Net_Total,
    this.hdr_dis_value,
    this.Cust_No,

    this.OrderNo,
    this.Date,
    this.bounce_Total,
    this.hdr_dis_per,

    this.disc_Total,
    this.Tax_Total,
    this.include_Tax,

    this.inovice_type,
    this.CashCustNm,
    this.Total,
    this.UserID,
    this.V_OrderNo,
    this.OrderDesc,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory SalesInvoiceHModelPost.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceHModelPost(
      Net_Total: map['Net_Total'],
      hdr_dis_value: map['hdr_dis_value'],
      Cust_No: map['Cust_No'],

      OrderNo: map['OrderNo'],
      Date: map['Date'],
      bounce_Total: map['bounce_Total'],

      hdr_dis_per: map['hdr_dis_per'],
      disc_Total: map['disc_Total'],

      Tax_Total: map['Tax_Total'],
      include_Tax: map['include_Tax'],

      inovice_type: map['inovice_type'],
      CashCustNm: map['CashCustNm'],
      Total: map['Total'],


      UserID: map['UserID'],
      V_OrderNo: map['V_OrderNo'],
      OrderDesc: map['OrderDesc'],



    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'Net_Total': Net_Total,
      'hdr_dis_value': hdr_dis_value,
      'Cust_No': Cust_No,

      'OrderNo': OrderNo,
      'Date': Date,
      'bounce_Total': bounce_Total,

      'hdr_dis_per': hdr_dis_per, // Convert DateTime to ISO 8601 string
      'disc_Total': disc_Total,

      'Tax_Total': Tax_Total,
      'include_Tax': include_Tax,

      'inovice_type': inovice_type,
      'CashCustNm': CashCustNm,
      'Total': Total, // Convert DateTime to ISO 8601 string

      'UserID': UserID,
      'V_OrderNo': V_OrderNo,
      'OrderDesc': OrderDesc, //

     
    };


  }


 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['Net_Total'] = this.Net_Total.toString();
   data['hdr_dis_value'] = this.hdr_dis_value.toString();
   data['Cust_No'] = this.Cust_No.toString();

   data['OrderNo'] = this.OrderNo.toString();
   data['Date'] = this.Date.toString();
   data['bounce_Total'] = this.bounce_Total.toString();

   data['hdr_dis_per'] = this.hdr_dis_per.toString();
   data['disc_Total'] = this.disc_Total.toString();

   data['Tax_Total'] = this.Tax_Total.toString();
   data['include_Tax'] = this.include_Tax.toString();

   data['inovice_type'] = this.inovice_type.toString();
   data['CashCustNm'] = this.CashCustNm.toString();
   data['Total'] = this.Total.toString();

   data['UserID'] = this.UserID.toString();
   data['V_OrderNo'] = this.V_OrderNo.toString();
   data['OrderDesc'] = this.OrderDesc.toString();

   return data;
 }





}