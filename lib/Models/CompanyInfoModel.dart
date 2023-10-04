class CompanyInfoModel {
  int? id;
  String? address;
  int? cID;
  String? cName;
  String? superVisor;
  String? taxNo1;
  String? taxNo2;
  int? allowDay;
  String? lat;
  String? longitude; // Rename 'long' to 'longitude'
  String? startDate;
  String? cMobile;

  CompanyInfoModel({
    this.id,
    this.address,
    this.cID,
    this.cName,
    this.superVisor,
    this.taxNo1,
    this.taxNo2,
    this.allowDay,
    this.lat,
    this.longitude, // Rename 'long' to 'longitude'
    this.startDate,
    this.cMobile,
  });

  factory CompanyInfoModel.fromMap(Map<String, dynamic> map) {
    return CompanyInfoModel(
      id: map['id'],
      address: map['Address'],
      cID: map['CID'],
      cName: map['CName'],
      superVisor: map['SuperVisor'],
      taxNo1: map['TaxNo1'],
      taxNo2: map['TaxNo2'],
      allowDay: map['AllowDay'],
      lat: map['Lat'],
      longitude: map['Long'], // Rename 'long' to 'longitude'
      startDate: map['StartDate'],
      cMobile: map['CMobile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Address': address,
      'CID': cID,
      'CName': cName,
      'SuperVisor': superVisor,
      'TaxNo1': taxNo1,
      'TaxNo2': taxNo2,
      'AllowDay': allowDay,
      'Lat': lat,
      'Long': longitude, // Rename 'long' to 'longitude'
      'StartDate': startDate,
      'CMobile': cMobile,
    };
  }
}