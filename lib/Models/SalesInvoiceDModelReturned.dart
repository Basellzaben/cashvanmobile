class SalesInvoiceDModelReturned {


  String? bounce;
  String? dis_Amt;
  String? discount;
  String? unite;
  String? no;
  String? price;
  String? orgPrice;
  String? qty;
  String? newqty='1';
  String? tax;
  String? tax_Amt;
  String? total;
  String? itemname;
  String? uname;


  SalesInvoiceDModelReturned({
    this.bounce,
    this.dis_Amt,
    this.discount,
    this.unite,
    this.no,
    this.price,
    this.orgPrice,
    this.qty,
    this.newqty,
    this.tax,
    this.tax_Amt,
    this.total,
    this.itemname,
    this.uname,
  });


  factory SalesInvoiceDModelReturned.fromJson(Map<String?, dynamic> json) {
    return SalesInvoiceDModelReturned(
      bounce: json['bounce'],
      dis_Amt: json['dis_Amt'],
      discount: json['discount'],
      unite: json['unite'],
      no: json['no'],
      price: json['price'],
      orgPrice: json['orgPrice'],
      qty: json['qty'],
      newqty: json['newqty'],
      tax: json['tax'],
      tax_Amt: json['tax_Amt'],
      total: json['total'],
        itemname: json['itemname'],
      uname: json['uname'],

    );
  }

  // Factory constructor to create a ManLogTransModel object from a map
  factory SalesInvoiceDModelReturned.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceDModelReturned(
      bounce: map['bounce'],
      dis_Amt: map['dis_Amt'],
      discount: map['discount'],
      unite: map['unite'],
      no: map['no'],
      price: map['price'],
      orgPrice: map['orgPrice'],
      qty: map['qty'],
      newqty: map['newqty'],
      tax: map['tax'],
      tax_Amt: map['tax_Amt'],
      total: map['total'],
        itemname: map['itemname'],
      uname: map['uname'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'bounce': bounce,
      'dis_Amt': dis_Amt,
      'discount': discount,

      'unite': unite,
      'no': no,
      'price': price,

      'orgPrice': orgPrice, // Convert noTime to ISO 8601 string
      'qty': qty,
      'newqty': newqty,

      'tax': tax,
      'tax_Amt': tax_Amt,

      'total': total,
      'itemname': itemname,
      'uname': uname,

    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bounce'] = this.bounce.toString();
    data['dis_Amt'] = this.dis_Amt.toString();
    data['discount'] = this.discount.toString();

    data['unite'] = this.unite.toString();
    data['no'] = this.no.toString();
    data['price'] = this.price.toString();

    data['orgPrice'] = this.orgPrice.toString();
    data['qty'] = this.qty.toString();
    data['newqty'] = this.newqty.toString();

    data['tax'] = this.tax.toString();
    data['tax_Amt'] = this.tax_Amt.toString();

    data['total'] = this.total.toString();
    data['itemname'] = this.itemname.toString();
    data['uname'] = this.uname.toString();

    return data;
  }
}
