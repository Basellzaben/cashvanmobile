class SalesInvoiceDModelPost {

  double? Bounce;
  double? Dis_Amt;
  double? Discount;
  int? Unite;
  String? no;
  double? price;
  double? ItemOrgPrice;
  double? Qty;
  double? Tax;
  double? Tax_Amt;
  double? Total;

  SalesInvoiceDModelPost({
    this.Bounce,
    this.Dis_Amt,
    this.Discount,
    this.Unite,
    this.no,
    this.price,
    this.ItemOrgPrice,
    this.Qty,
    this.Tax,
    this.Tax_Amt,
    this.Total,
  });

  factory SalesInvoiceDModelPost.fromMap(Map<String, dynamic> map) {
    return SalesInvoiceDModelPost(
      Bounce: map['Bounce'],
      Dis_Amt: map['Dis_Amt'],
      Discount: map['Discount'],
      Unite: map['Unite'],
      no: map['no'],
      price: map['price'],
      ItemOrgPrice: map['ItemOrgPrice'],
      Qty: map['Qty'],
      Tax: map['Tax'],
      Tax_Amt: map['Tax_Amt'],
      Total: map['Total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Bounce': Bounce,
      'Dis_Amt': Dis_Amt,
      'Discount': Discount,
      'Unite': Unite,
      'no': no,
      'price': price,
      'ItemOrgPrice': ItemOrgPrice,
      'Qty': Qty,
      'Tax': Tax,
      'Tax_Amt': Tax_Amt,
      'Total': Total,
    };
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Bounce'] = this.Bounce.toString();
    data['Dis_Amt'] = this.Dis_Amt.toString();
    data['Discount'] = this.Discount.toString();
    data['Unite'] = this.Unite.toString();
    data['no'] = this.no.toString();
    data['price'] = this.price.toString();
    data['ItemOrgPrice'] = this.ItemOrgPrice.toString();
    data['Qty'] = this.Qty.toString();
    data['Tax'] = this.Tax.toString();
    data['Tax_Amt'] = this.Tax_Amt.toString();
    data['Total'] = this.Total.toString();

    return data;
  }

}
