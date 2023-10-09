class ManLogTransModel {
  int? id;
  int? manNo;
  int? custNo;
  int? screenCode;
  int? actionNo;
  String? transNo;
  String? transDate;
  String? tabletId;
  String? batteryCharge;
  String? notes;
  int? posted;

  ManLogTransModel({
    this.id,
    this.manNo,
    this.custNo,
    this.screenCode,
    this.actionNo,
    this.transNo,
    this.transDate,
    this.tabletId,
    this.batteryCharge,
    this.notes,
    this.posted,
  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory ManLogTransModel.fromMap(Map<String, dynamic> map) {
    return ManLogTransModel(
      id: map['ID'],
      manNo: map['ManNo'],
      custNo: map['CustNo'],
      screenCode: map['ScreenCode'],
      actionNo: map['ActionNo'],
      transNo: map['TransNo'],
      transDate: map['Trans_Date'],
      tabletId: map['TabletId'],
      batteryCharge: map['BattryCharge'],
        notes: map['Notes'],
      posted: map['posted'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'ManNo': manNo,
      'CustNo': custNo,
      'ScreenCode': screenCode,
      'ActionNo': actionNo,
      'TransNo': transNo,
      'Trans_Date': transDate, // Convert DateTime to ISO 8601 string
      'TabletId': tabletId,
      'BattryCharge': batteryCharge,
      'Notes': notes,
      'posted': posted,

    };
  }
}