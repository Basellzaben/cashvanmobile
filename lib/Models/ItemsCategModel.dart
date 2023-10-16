class ItemsCategModel {




  String? ItemCode;
  int? CategNo;
  String? Price;
  String? MinPrice;
  String? dis;

  String? bounce;
  String? UnitNo;

  ItemsCategModel({
    this.ItemCode,
    this.CategNo,
    this.Price,
    this.MinPrice,
    this.dis,
    this.bounce,
    this.UnitNo,
  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory ItemsCategModel.fromMap(Map<String, dynamic> map) {
    return ItemsCategModel(

      ItemCode: map['ItemCode'],
      CategNo: map['CategNo'],
      Price: map['Price'],
      MinPrice: map['MinPrice'],
      dis: map['dis'],

      bounce: map['bounce'],
      UnitNo: map['UnitNo'],


    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'ItemCode': ItemCode,
      'CategNo': CategNo, // Convert DateTime to ISO 8601 string
      'Price': Price,
      'MinPrice': MinPrice,
      'dis': dis,

      'bounce': bounce,
      'UnitNo': UnitNo,

    };
  }

  ItemsCategModel.fromJson(Map<String, dynamic> json) {
    ItemCode = json['itemCode'];
    CategNo = json['categNo'];
    Price = json['price'];
    MinPrice = json['minPrice'];
    dis = json['dis'];
    bounce = json['bonus'];
    UnitNo = json['unitNo'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.ItemCode;
    data['CategNo'] = this.CategNo;
    data['Price'] = this.Price;
    data['MinPrice'] = this.MinPrice;
    data['dis'] = this.dis;

    data['bounce'] = this.bounce;
    data['UnitNo'] = this.UnitNo;

    return data;
  }


}
