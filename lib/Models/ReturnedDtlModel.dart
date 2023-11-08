class ReturnedDtlModel {

  String? Bounce;
  String? Unite;
  String? no;
  String? price;
  String? ItemOrgPrice;
  String? Qty;
  String? Tax;
  String? Tax_Amt;
  String? Total;
  String? Note;
  String? Damaged;

  ReturnedDtlModel({
    this.Bounce,
    this.Note,
    this.Damaged,
    this.Unite,
    this.no,
    this.price,
    this.ItemOrgPrice,
    this.Qty,
    this.Tax,
    this.Tax_Amt,
    this.Total,
  });

  factory ReturnedDtlModel.fromJson(Map<String?, dynamic> json) {
    return ReturnedDtlModel(
      Bounce: json['Bounce'],
      Note: json['Note'],
      Damaged: json['Damaged'],
      Unite: json['Unite'],
      no: json['no'],
      price: json['price'],
      ItemOrgPrice: json['ItemOrgPrice'],
      Qty: json['Qty'],
      Tax: json['Tax'],
      Tax_Amt: json['Tax_Amt'],
      Total: json['Total'],
    );
  }

  // Factory constructor to create a ManLogTransModel object from a map
  factory ReturnedDtlModel.fromMap(Map<String, dynamic> map) {
    return ReturnedDtlModel(
      Bounce: map['Bounce'],
      Note: map['Note'],
      Damaged: map['Damaged'],
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

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'Bounce': Bounce,
      'Note': Note,
      'Damaged': Damaged,
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
    data['Note'] = this.Note.toString();
    data['Damaged'] = this.Damaged.toString();
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
