class CustomerinitModel {

  int? id;
  String? CusName;
  String? OrderNo;
  String? Area;
  String? CustType;
  String? Mobile;
  String? Acc;
  String? Lat;
  String? Lng;
  String? GpsLocation;
  String? COMPUTERNAME;
  String? UserID;
  String? posted;


  CustomerinitModel({
    this.id,
    this.CusName,
    this.OrderNo,
    this.Area,
    this.CustType,
    this.Mobile,
    this.Acc,
    this.Lat,

    this.Lng,
    this.GpsLocation,
    this.COMPUTERNAME,
    this.UserID,
    this.posted,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory CustomerinitModel.fromMap(Map<String, dynamic> map) {
    return CustomerinitModel(

      id: map['id'],
      CusName: map['CusName'],
      OrderNo: map['OrderNo'],
      Area: map['Area'],
      CustType: map['CustType'],
      Mobile: map['Mobile'],
      Acc: map['Acc'],
      Lat: map['Lat'],

      Lng: map['Lng'],
      GpsLocation: map['GpsLocation'],
      COMPUTERNAME: map['COMPUTERNAME'],
        UserID: map['UserID'],
      posted: map['posted'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'CusName': CusName,
      'OrderNo': OrderNo, // Convert DateTime to ISO 8601 string
      'Area': Area,
      'CustType': CustType,
      'Mobile': Mobile,
      'Acc': Acc,
      'Lat': Lat,

      'Lng': Lng,
      'GpsLocation': GpsLocation,
      'COMPUTERNAME': COMPUTERNAME,
      'UserID': UserID,
      'posted': posted,

    };
  }

  CustomerinitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CusName = json['CusName'];
    OrderNo = json['OrderNo'];
    Area = json['Area'];
    CustType = json['CustType'];
    Mobile = json['Mobile'];
    Acc = json['bonus'];
    Lat = json['Lat'];

    Lng = json['Lng'];
    GpsLocation = json['GpsLocation'];
    COMPUTERNAME = json['COMPUTERNAME'];
    UserID = json['UserID'];
    posted = json['posted'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CusName'] = this.CusName;
    data['OrderNo'] = this.OrderNo;
    data['Area'] = this.Area;
    data['CustType'] = this.CustType;
    data['Mobile'] = this.Mobile;
    data['Acc'] = this.Acc;
    data['Lat'] = this.Lat;

    data['Lng'] = this.Lng;
    data['GpsLocation'] = this.GpsLocation;
    data['COMPUTERNAME'] = this.COMPUTERNAME;
    data['UserID'] = this.UserID;
    data['posted'] = this.posted;

    return data;
  }


}
