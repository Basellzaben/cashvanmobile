class CustomersModel {
  int? id;
  int? customerId;
  String? branchName;
  String? branchTel;
  int? branchRepNo;
  String? locX;
  String? locY;
  bool? sat;
  bool? sun;
  bool? mon;
  bool? tues;
  bool? wens;
  bool? thurs;
  bool? frid;
  int? everyWeek;
  int? visitWeek;
  String? acc;
  String? catNo;
  String? payHow;
  String? discountPercent;
  String? allowPeriod;
  String? taxSts;
  String? paytype;
  String? acCCHECK;
  String? pamenTPERIODNO;
  Null? expirePeriod;
  String? iDFacility;
  String? allowInviceWithFlag;
  String? closeVisitWithoutimg;

  CustomersModel(
      {this.id,
        this.customerId,
        this.branchName,
        this.branchTel,
        this.branchRepNo,
        this.locX,
        this.locY,
        this.sat,
        this.sun,
        this.mon,
        this.tues,
        this.wens,
        this.thurs,
        this.frid,
        this.everyWeek,
        this.visitWeek,
        this.acc,
        this.catNo,
        this.payHow,
        this.discountPercent,
        this.allowPeriod,
        this.taxSts,
        this.paytype,
        this.acCCHECK,
        this.pamenTPERIODNO,
        this.expirePeriod,
        this.iDFacility,
        this.allowInviceWithFlag,
        this.closeVisitWithoutimg});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    branchName = json['branchName'];
    branchTel = json['branchTel'];
    branchRepNo = json['branchRepNo'];
    locX = json['locX'];
    locY = json['locY'];
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tues = json['tues'];
    wens = json['wens'];
    thurs = json['thurs'];
    frid = json['frid'];
    everyWeek = json['everyWeek'];
    visitWeek = json['visitWeek'];
    acc = json['acc'];
    catNo = json['catNo'];
    payHow = json['pay_How'];
    discountPercent = json['discount_Percent'];
    allowPeriod = json['allow_Period'];
    taxSts = json['taxSts'];
    paytype = json['paytype'];
    acCCHECK = json['acC_CHECK'];
    pamenTPERIODNO = json['pamenT_PERIOD_NO'];
    expirePeriod = json['expirePeriod'];
    iDFacility = json['iD_facility'];
    allowInviceWithFlag = json['allowInviceWithFlag'];
    closeVisitWithoutimg = json['closeVisitWithoutimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['branchName'] = this.branchName;
    data['branchTel'] = this.branchTel;
    data['branchRepNo'] = this.branchRepNo;
    data['locX'] = this.locX;
    data['locY'] = this.locY;
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tues'] = this.tues;
    data['wens'] = this.wens;
    data['thurs'] = this.thurs;
    data['frid'] = this.frid;
    data['everyWeek'] = this.everyWeek;
    data['visitWeek'] = this.visitWeek;
    data['acc'] = this.acc;
    data['catNo'] = this.catNo;
    data['pay_How'] = this.payHow;
    data['discount_Percent'] = this.discountPercent;
    data['allow_Period'] = this.allowPeriod;
    data['taxSts'] = this.taxSts;
    data['paytype'] = this.paytype;
    data['acC_CHECK'] = this.acCCHECK;
    data['pamenT_PERIOD_NO'] = this.pamenTPERIODNO;
    data['expirePeriod'] = this.expirePeriod;
    data['iD_facility'] = this.iDFacility;
    data['allowInviceWithFlag'] = this.allowInviceWithFlag;
    data['closeVisitWithoutimg'] = this.closeVisitWithoutimg;
    return data;
  }
}