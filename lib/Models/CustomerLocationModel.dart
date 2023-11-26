
class CustomerLocationModel {

  int? id;
  String? CustNo;
  String? ManNo;
  String? CustName;
  String? Lat_X;
  String? Lat_Y;
  String? Locat;
  String? MobileNo;
  String? Note;
  String? Tr_Date;
  String? PersonNm;
  String? posted;


  CustomerLocationModel({
    this.id,
    this.CustNo,
    this.ManNo,
    this.CustName,
    this.Lat_X,
    this.Lat_Y,
    this.Locat,
    this.MobileNo,


    this.Note,
    this.Tr_Date,
    this.PersonNm,
    this.posted,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory CustomerLocationModel.fromMap(Map<String, dynamic> map) {
    return CustomerLocationModel(

      id: map['id'],
      CustNo: map['CustNo'],
      ManNo: map['ManNo'],
      CustName: map['CustName'],
      Lat_X: map['Lat_X'],
      Lat_Y: map['Lat_Y'],
      Locat: map['Locat'],
      MobileNo: map['MobileNo'],


      Note: map['Note'],
      Tr_Date: map['Tr_Date'],
      PersonNm: map['PersonNm'],
      posted: map['posted'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'CustNo': CustNo,
      'ManNo': ManNo, // Convert DateTime to ISO 8601 string
      'CustName': CustName,
      'Lat_X': Lat_X,
      'Lat_Y': Lat_Y,
      'Locat': Locat,
      'MobileNo': MobileNo,


      'Note': Note,
      'Tr_Date': Tr_Date,
      'PersonNm': PersonNm,
      'posted': posted,

    };
  }

  CustomerLocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CustNo = json['CustNo'];
    ManNo = json['ManNo'];
    CustName = json['CustName'];
    Lat_X = json['Lat_X'];
    Lat_Y = json['Lat_Y'];
    Locat = json['bonus'];
    MobileNo = json['MobileNo'];


    Note = json['Note'];
    Tr_Date = json['Tr_Date'];
    PersonNm = json['PersonNm'];
    posted = json['posted'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CustNo'] = this.CustNo;
    data['ManNo'] = this.ManNo;
    data['CustName'] = this.CustName;
    data['Lat_X'] = this.Lat_X;
    data['Lat_Y'] = this.Lat_Y;
    data['Locat'] = this.Locat;
    data['MobileNo'] = this.MobileNo;

    data['Note'] = this.Note;
    data['Tr_Date'] = this.Tr_Date;
    data['PersonNm'] = this.PersonNm;
    data['posted'] = this.posted;

    return data;
  }


}

