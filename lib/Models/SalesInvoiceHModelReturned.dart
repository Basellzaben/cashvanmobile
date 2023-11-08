class SalesInvoiceHModelReturned {



  String? net_Total	;
 String? hdr_dis_value ;
 String? cust_No      ;
 String? orderNo     ;
 String? date		  ;
  String? bounce_Total   ;
  String? hdr_dis_per    ;
  String? disc_Total
  ;
  String? tax_Total     ;
  String? include_Tax   ;
   int?   invoice_type   ;
  String? total	   ;
  String? userID       ;
  String?   v_OrderNo     ;
 String?  posted    ;





 SalesInvoiceHModelReturned({
    this.net_Total,
    this.hdr_dis_value,
    this.cust_No,

    this.orderNo,
    this.date,
    this.bounce_Total,
    this.hdr_dis_per,

    this.disc_Total,
    this.tax_Total,
    this.include_Tax,

    this.invoice_type,
    this.total,
    this.userID,
    this.v_OrderNo,
    this.posted,

  });


  factory SalesInvoiceHModelReturned.fromJson(Map<String?, dynamic> json) {
    return SalesInvoiceHModelReturned(
      net_Total: json['net_Total'],
      hdr_dis_value: json['hdr_dis_value'],
      cust_No: json['cust_No'],

      orderNo: json['orderNo'],
      date: json['date'],
      bounce_Total: json['bounce_Total'],

      hdr_dis_per: json['hdr_dis_per'],
      disc_Total: json['disc_Total'],

      tax_Total: json['tax_Total'],
      include_Tax: json['include_Tax'],

      invoice_type: json['invoice_type'],
      total: json['total'],


      userID: json['userID'],
      v_OrderNo: json['v_OrderNo'],
      posted: json['posted'],



    );
  }

  // Factory constructor to create a ManLogTransModel object from a map
  factory SalesInvoiceHModelReturned.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceHModelReturned(
      net_Total: map['net_Total'],
      hdr_dis_value: map['hdr_dis_value'],
      cust_No: map['cust_No'],

      orderNo: map['orderNo'],
      date: map['date'],
      bounce_Total: map['bounce_Total'],

      hdr_dis_per: map['hdr_dis_per'],
      disc_Total: map['disc_Total'],

      tax_Total: map['tax_Total'],
      include_Tax: map['include_Tax'],

      invoice_type: map['invoice_type'],
      total: map['total'],


      userID: map['userID'],
      v_OrderNo: map['v_OrderNo'],
      posted: map['posted'],



    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'net_Total': net_Total,
      'hdr_dis_value': hdr_dis_value,
      'cust_No': cust_No,

      'orderNo': orderNo,
      'date': date,
      'bounce_Total': bounce_Total,

      'hdr_dis_per': hdr_dis_per, // Convert dateTime to ISO 8601 string
      'disc_Total': disc_Total,

      'tax_Total': tax_Total,
      'include_Tax': include_Tax,

      'invoice_type': invoice_type,
      'total': total,

      'userID': userID,
      'v_OrderNo': v_OrderNo,
      'posted': posted, //

     
    };


  }


 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['net_Total'] = this.net_Total.toString();
   data['hdr_dis_value'] = this.hdr_dis_value.toString();
   data['cust_No'] = this.cust_No.toString();

   data['orderNo'] = this.orderNo.toString();
   data['date'] = this.date.toString();
   data['bounce_Total'] = this.bounce_Total.toString();

   data['hdr_dis_per'] = this.hdr_dis_per.toString();
   data['disc_Total'] = this.disc_Total.toString();

   data['tax_Total'] = this.tax_Total.toString();
   data['include_Tax'] = this.include_Tax.toString();

   data['invoice_type'] = this.invoice_type.toString();
   data['total'] = this.total.toString();

   data['userID'] = this.userID.toString();
   data['v_OrderNo'] = this.v_OrderNo.toString();
   data['posted'] = this.posted.toString();

   return data;
 }





}