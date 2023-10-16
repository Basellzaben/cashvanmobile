class SalesInvoiceDModel {
  String? Bounce;
  String? Dis_Amt;
  String? Discount;
  String? ItemOrgPrice;
  String? Operand;
  String? ProBounce;
  String? Pro_amt;
  String? Pro_bounce;
  String? Pro_dis_Per;
  String? Unite;
  String? no;
  String? price;
  String? pro_Total;
  String? qty;
  String? tax;
  String? tax_Amt;
  String? total;
  String? orderno;
  String? name;
  String? unitname;



  SalesInvoiceDModel({
    this.Bounce,
    this.Dis_Amt,
    this.Discount,
    this.ItemOrgPrice,
    this.Operand,
    this.ProBounce,
    this.Pro_amt,
    this.Pro_bounce,
    this.Pro_dis_Per,
    this.Unite,
    this.no,
    this.price,
    this.pro_Total,
    this.qty,
    this.tax,
    this.tax_Amt,
    this.total,
    this.orderno,
    this.name,
    this.unitname,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory SalesInvoiceDModel.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceDModel(
      Bounce: map['Bounce'],
      Dis_Amt: map['Dis_Amt'],
      Discount: map['Discount'],
      ItemOrgPrice: map['ItemOrgPrice'],
      Operand: map['Operand'],
      ProBounce: map['Pro_bounce'],
      Pro_amt: map['Pro_amt'],
      Pro_bounce: map['Pro_bounce'],
      Pro_dis_Per: map['Pro_dis_Per'],
      Unite: map['Unite'],
      no: map['no'],
      price: map['price'],
      pro_Total: map['pro_Total'],
      qty: map['qty'],
      tax: map['tax'],
      tax_Amt: map['tax_Amt'],
      total: map['total'],
      orderno: map['orderno'],
      name: map['name'],
      unitname: map['unitname'],



    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'Bounce': Bounce,
      'Dis_Amt': Dis_Amt,
      'Discount': Discount,
      'ItemOrgPrice': ItemOrgPrice,
      'Operand': Operand,
      'Pro_bounce': ProBounce,
      'Pro_amt': Pro_amt, // Convert DateTime to ISO 8601 string
      'Pro_bounce': Pro_bounce,
      'Pro_dis_Per': Pro_dis_Per,
      'Unite': Unite,
      'no': no,
      'price': price,
      'pro_Total': pro_Total,
      'qty': qty, // Convert DateTime to ISO 8601 string
      'tax': tax,
      'tax_Amt': tax_Amt,
      'total': total,
      'orderno': orderno,
      'name': name,
      'unitname': unitname,



    };
  }
}