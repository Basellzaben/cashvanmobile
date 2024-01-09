class PaymentModel {


  
  String? id;
  String? vouchtype;
  String? orderno;
  String? date;
  String? acc;
  String? amt;


  String? notes;
  String? curno;
  String? userid;
  String? transdate;
  String? posted;
  String? v_orderno;

  String? checktotal;
  String? fromsales;
  String? cash;


  PaymentModel({
    required this.vouchtype,
    required this.id,
    required this.orderno,
    required this.date,
    required this.acc,
    required this.amt,



    required this.notes,
    required this.curno,
    required this.userid,
    required this.transdate,
    required this.posted,
    required this.v_orderno,




    required this.checktotal,
    required this.fromsales,
    required this.cash,


  }
      );

  PaymentModel.fromMap(Map<dynamic, dynamic> res)
      : vouchtype = res["vouchtype"].toString(),
        id = res["id"].toString(),
        orderno = res["orderno"].toString(),
        date = res["date"].toString(),
        acc = res["acc"].toString(),
        amt = res["amt"].toString(),

  notes = res["notes"].toString(),
  curno = res["curno"].toString(),
  userid = res["userid"].toString(),
  transdate = res["transdate"].toString(),
  posted = res["posted"].toString(),
  v_orderno = res["v_orderno"].toString(),




  checktotal = res["checktotal"].toString(),
  fromsales = res["fromsales"].toString(),
  cash = res["cash"].toString();

  Map<String, Object?> toMap() {
    return {
      'vouchtype': vouchtype,
      'id': id,
      'orderno': orderno,
      'date': date,
      'acc': acc,
      'amt': amt,

      'notes': notes,
      'curno': curno,
      'userid': userid,
      'transdate': transdate,
      'posted': posted,
      'v_orderno': v_orderno,
      'checktotal': checktotal,
      'fromsales': fromsales,
      'cash': cash,




  };
  }

  PaymentModel.fromJson(Map<String, dynamic> json) {
    vouchtype = json['vouchtype'];
    id = json['id'];
    orderno = json['orderno'];
    date = json['date'];
    acc = json['acc'];
    amt = json['amt'];
    notes = json['notes'];
    curno = json['curno'];
    userid = json['userid'];
    transdate = json['transdate'];
    posted = json['posted'];
    v_orderno = json['v_orderno'];

    checktotal = json['checktotal'];
    fromsales = json['fromsales'];
    cash = json['cash'];
  }


}
