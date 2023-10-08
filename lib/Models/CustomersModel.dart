class CustomersModel {

  String? customerid;
  String? branchname;
  String? branchtel;
  String? branchrepno;
  String? locx;
  String? locy;
  String? sat;
  String? sun;
  String? mon;
  String? tues;
  String? wens;
  String? thurs;
  String? frid;
  String? everyweek;
  String? visitweek;
  String? acc;
  String? catno;
  String? pay_how;
  String? discount_percent;
  String? allow_period;
  String? taxsts;
  String?  paytype;
  String?  acc_check;
  String? pament_period_no ;
  String? expireperiod;
  String? id_facility;
  String? allowinvicewithflag;
  String? closevisitwithoutimg;

  CustomersModel(
      {
        this.customerid,
        this.branchname,
        this.branchtel,
        this.branchrepno,
        this.locx,
        this.locy,
        this.sat,
        this.sun,
        this.mon,
        this.tues,
        this.wens,
        this.thurs,
        this.frid,
        this.everyweek,
        this.visitweek,
        this.acc,
        this.catno,
        this.pay_how,
        this.discount_percent,
        this.allow_period,
        this.taxsts,
        this.paytype,
        this.acc_check,
        this.pament_period_no,
        this.expireperiod,
        this.id_facility,
        this.allowinvicewithflag,
        this.closevisitwithoutimg});
  factory CustomersModel.fromMap(Map<String, dynamic> map) {
    return CustomersModel(
      customerid: map['customerid'],
      branchname: map['branchname'],
      branchtel: map['branchtel'],
      branchrepno: map['branchrepno'],
      locx: map['locx'],
      locy: map['locy'],
      sat: map['sat'],
      sun: map['sun'],
      mon: map['mon'],
      tues: map['tues'],
      wens: map['wens'],
      thurs: map['thurs'],
      frid: map['frid'],
      everyweek: map['everyweek'],
      visitweek: map['visitweek'],
      acc: map['acc'],
      catno: map['catno'],
      pay_how: map['pay_how'],
      discount_percent: map['discount_percent'],
      allow_period: map['allow_period'],
      taxsts: map['taxsts'],
      paytype: map['paytype'],
      acc_check: map['acc_check'],
      pament_period_no: map['pament_period_no'],
      expireperiod: map['expireperiod'],
      id_facility: map['id_facility'],
      allowinvicewithflag: map['allowinvicewithflag'],
      closevisitwithoutimg: map['closevisitwithoutimg'],
    );
  }

  CustomersModel.fromJson(Map<String, dynamic> json) {
    customerid = json['customerid'];
    branchname = json['branchname'];
    branchtel = json['branchtel'];
    branchrepno = json['branchrepno'];
    locx = json['locx'];
    locy = json['locy'];
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tues = json['tues'];
    wens = json['wens'];
    thurs = json['thurs'];
    frid = json['frid'];
    everyweek = json['everyweek'];
    visitweek = json['visitweek'];
    acc = json['acc'];
    catno = json['catno'];
    pay_how = json['pay_how'];
    discount_percent = json['discount_percent'];
    allow_period = json['allow_period'];
    taxsts = json['taxsts'];
    paytype = json['paytype'];
    acc_check = json['acc_check'];
    pament_period_no = json['pament_period_no'];
    expireperiod = json['expireperiod'];
    id_facility = json['id_facility'];
    allowinvicewithflag = json['allowinvicewithflag'];
    closevisitwithoutimg = json['closevisitwithoutimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerid'] = this.customerid;
    data['branchname'] = this.branchname;
    data['branchtel'] = this.branchtel;
    data['branchrepno'] = this.branchrepno;
    data['locx'] = this.locx;
    data['locy'] = this.locy;
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tues'] = this.tues;
    data['wens'] = this.wens;
    data['thurs'] = this.thurs;
    data['frid'] = this.frid;
    data['everyweek'] = this.everyweek;
    data['visitweek'] = this.visitweek;
    data['acc'] = this.acc;
    data['catno'] = this.catno;
    data['pay_how'] = this.pay_how;
    data['discount_percent'] = this.discount_percent;
    data['allow_period'] = this.allow_period;
    data['taxsts'] = this.taxsts;
    data['paytype'] = this.paytype;

    data['acc_check'] = this.acc_check;
    data['pament_period_no'] = this.pament_period_no;
    data['expireperiod'] = this.expireperiod;
    data['id_facility'] = this.id_facility;
    data['allowinvicewithflag'] = this.allowinvicewithflag;
    data['closevisitwithoutimg'] = this.closevisitwithoutimg;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'customerid': customerid,
      'branchname': branchname,
      'branchtel': branchtel,
      'branchrepno': branchrepno,
      'locx': locx,
      'locy': locy,
      'sat': sat,
      'sun': sun,
      'mon': mon,
      'tues': tues,
      'wens': wens,
      'thurs': thurs,
      'frid': frid,
      'everyweek': everyweek,
      'visitweek': visitweek,
      'acc': acc,
      'catno': catno,
      'pay_how': pay_how,
      'discount_percent': discount_percent,
      'allow_period': allow_period,
      'taxsts': taxsts,
      'paytype': paytype,
      'acc_check': acc_check,
      'pament_period_no': pament_period_no,
      'expirePeriod': expireperiod,
      'id_facility': id_facility,
      'allowinvicewithflag': allowinvicewithflag,
      'closevisitwithoutimg': closevisitwithoutimg,

    };
  }
}