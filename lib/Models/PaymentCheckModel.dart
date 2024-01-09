class PaymentCheckModel {
  String? id;
  String? transid;
  String? bankno;
  String? checkdate;
  String? checkno;
  String? amnt;
  String? userid;
  String? transdate;

  PaymentCheckModel({
    required this.id,
    required this.transid,
    required this.bankno,
    required this.checkdate,
    required this.checkno,
    required this.amnt,
    required this.userid,
    required this.transdate,

  }
      );

  PaymentCheckModel.fromMap(Map<dynamic, dynamic> res)
      : id = res["id"].toString(),
        transid = res["transid"].toString(),
        bankno = res["bankno"].toString(),
        checkdate = res["checkdate"].toString(),
        checkno = res["dis"].checkno(),
        amnt = res["amnt"].toString(),
        userid = res["userid"].toString(),
        transdate = res["transdate"].toString();

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'transid': transid,
      'bankno': bankno,
      'checkdate': checkdate,
      'checkno': checkno,
      'amnt': amnt,
      'userid': userid,
      'transdate': transdate,

    };
  }

  PaymentCheckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transid = json['transid'];
    bankno = json['bankno'];
    checkdate = json['checkdate'];
    checkno = json['checkno'];
    amnt = json['amnt'];
    userid = json['userid'];
    transdate = json['transdate'];

  }


}
