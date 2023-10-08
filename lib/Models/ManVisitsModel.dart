class ManVisitsModel {
  int? id;
  int? cusNo;
  int? dayNum;
  String? Start_Time;
  String? End_Time;
  int? manNo;
  String? Tr_Data;
  int? no;
  int? orderNo;
  String? note;
  String? X_Lat;
  String? Y_Long;
  String? loct;
  int? isException;
  String? computerName;
  int? orderInVisit;
  int? duration;
  int? posted;
  String? CusName;


  ManVisitsModel({
    this.id,
    this.cusNo,
    this.dayNum,
    this.Start_Time,
    this.End_Time,
    this.manNo,
    this.Tr_Data,
    this.no,
    this.orderNo,
    this.note,
    this.X_Lat,
    this.Y_Long,
    this.loct,
    this.isException,
    this.computerName,
    this.orderInVisit,
    this.duration,
    this.posted,
    this.CusName

  });

  factory ManVisitsModel.fromMap(Map<String, dynamic> map) {
    return ManVisitsModel(
      id: map['ID'],
      cusNo: map['CusNo'],
      dayNum: map['DayNum'],
      Start_Time: map['Start_Time'],
      End_Time: map['End_Time'],
      manNo: map['ManNo'],
      Tr_Data: map['Tr_Data'],
      no: map['no'],
      orderNo: map['OrderNo'],
      note: map['Note'],
      X_Lat: map['X_Lat'],
      Y_Long: map['Y_Long'],
      loct: map['Loct'],
      isException: map['IsException'],
      computerName: map['COMPUTERNAME'],
      orderInVisit: map['orderinvisit'],
        duration: map['Duration'],
        posted: map['posted'],
      CusName: map['CusName'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'CusNo': cusNo,
      'DayNum': dayNum,
      'Start_Time': Start_Time,
      'End_Time': End_Time,
      'ManNo': manNo,
      'Tr_Data': Tr_Data,
      'no': no,
      'OrderNo': orderNo,
      'Note': note,
      'X_Lat': X_Lat,
      'Y_Long': Y_Long,
      'Loct': loct,
      'IsException': isException,
      'COMPUTERNAME': computerName,
      'orderinvisit': orderInVisit,
      'Duration': duration,
      'posted': posted,
      'CusName': CusName,

    };
  }
}