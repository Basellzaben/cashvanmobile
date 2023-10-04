class CustomersModel {
/*
  CustomerId INTEGER,
      BranchName TEXT,
  BranchTel TEXT,
      BranchRepNo INTEGER,
  LocX REAL,
      LocY REAL,
  Sat INTEGER,
      Sun INTEGER,
  Mon INTEGER,
      Tues INTEGER,
  Wens INTEGER,
      Thurs INTEGER,
  Frid INTEGER,
      EveryWeek INTEGER,
  VisitWeek INTEGER,
      Acc TEXT,
  CatNo INTEGER,
      Pay_How TEXT,
  Discount_Percent REAL,
      Allow_Period INTEGER,
  TaxSts TEXT,
      PAYTYPE TEXT,
  ACC_CHECK INTEGER,
      PAMENT_PERIOD_NO INTEGER,
  ExpirePeriod INTEGER,
      ID_facility INTEGER,
  AllowInviceWithFlag INTEGER,
      CloseVisitWithoutimg INTEGER
  */
  int? id;
  int? customerId;
  String? branchName;
  String? branchTel;
  int? branchRepNo;
  String? locX;
  String? locY;
  int? sat;
  int? sun;
  int? mon;
  int? tues;
  int? wens;
  int? thurs;
  int? frid;
  int? everyWeek;
  int? visitWeek;
  String? acc;
  String? catNo;
  String? pay_How;
  String? Discount_Percent;
  String? Allow_Period;
  String? taxSts;
  String? paytype;
  String? ACC_CHECK;
  String? PAMENT_PERIOD_NO;
  String? expirePeriod;
  String? ID_facility;
  String? AllowInviceWithFlag;
  String? closeVisitWithoutImg;

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
        this.pay_How,
        this.Discount_Percent,
        this.Allow_Period,
        this.taxSts,
        this.paytype,
        this.ACC_CHECK,
        this.PAMENT_PERIOD_NO,
        this.expirePeriod,
        this.ID_facility,
        this.AllowInviceWithFlag,
        this.closeVisitWithoutImg});
  factory CustomersModel.fromMap(Map<String, dynamic> map) {
    return CustomersModel(
      id: map['id'],
      customerId: map['customerId'],
      branchName: map['branchName'],
      branchTel: map['branchTel'],
      branchRepNo: map['branchRepNo'],
      locX: map['locX'],
      locY: map['locY'],
      sat: map['sat'],
      sun: map['sun'],
      mon: map['mon'],
      tues: map['tues'],
      wens: map['wens'],
      thurs: map['thurs'],
      frid: map['frid'],
      everyWeek: map['everyWeek'],
      visitWeek: map['visitWeek'],
      acc: map['acc'],
      catNo: map['catNo'],
      pay_How: map['pay_How'],
      Discount_Percent: map['Discount_Percent'],
      Allow_Period: map['Allow_Period'],
      taxSts: map['taxSts'],
      paytype: map['paytype'],
      ACC_CHECK: map['ACC_CHECK'],
      PAMENT_PERIOD_NO: map['PAMENT_PERIOD_NO'],
      expirePeriod: map['expirePeriod'],
      ID_facility: map['ID_facility'],
      AllowInviceWithFlag: map['AllowInviceWithFlag'],
      closeVisitWithoutImg: map['closeVisitWithoutImg'],
    );
  }

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
    pay_How = json['pay_How'];
    Discount_Percent = json['discount_Percent'];
    Allow_Period = json['allow_Period'];
    taxSts = json['taxSts'];
    paytype = json['paytype'];
    ACC_CHECK = json['acC_CHECK'];
    PAMENT_PERIOD_NO = json['pamenT_PERIOD_NO'];
    expirePeriod = json['expirePeriod'];
    ID_facility = json['iD_facility'];
    AllowInviceWithFlag = json['AllowInviceWithFlag'];
    closeVisitWithoutImg = json['closeVisitWithoutImg'];
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
    data['sun'] = this.sun!.toInt();
    data['mon'] = this.mon!.toInt();
    data['tues'] = this.tues!.toInt();
    data['wens'] = this.wens!.toInt();
    data['thurs'] = this.thurs!.toInt();
    data['frid'] = this.frid!.toInt();
    data['everyWeek'] = this.everyWeek!.toInt();
    data['visitWeek'] = this.visitWeek!.toInt();
    data['acc'] = this.acc;
    data['catNo'] = this.catNo;
    data['pay_How'] = this.pay_How;
    data['discount_Percent'] = this.Discount_Percent;
    data['allow_Period'] = this.Allow_Period;
    data['taxSts'] = this.taxSts;
    data['paytype'] = this.paytype;
    data['acC_CHECK'] = this.ACC_CHECK;
    data['pamenT_PERIOD_NO'] = this.PAMENT_PERIOD_NO;
    data['expirePeriod'] = this.expirePeriod;
    data['iD_facility'] = this.ID_facility;
    data['AllowInviceWithFlag'] = this.AllowInviceWithFlag;
    data['closeVisitWithoutImg'] = this.closeVisitWithoutImg;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'branchName': branchName,
      'branchTel': branchTel,
      'branchRepNo': branchRepNo,
      'locX': locX,
      'locY': locY,
      'sat': sat,
      'sun': sun,
      'mon': mon,
      'tues': tues,
      'wens': wens,
      'thurs': thurs,
      'frid': frid,
      'everyWeek': everyWeek,
      'visitWeek': visitWeek,
      'acc': acc,
      'catNo': catNo,
      'pay_How': pay_How,
      'Discount_Percent': Discount_Percent,
      'Allow_Period': Allow_Period,
      'taxSts': taxSts,
      'paytype': paytype,
      'ACC_CHECK': ACC_CHECK,
      'PAMENT_PERIOD_NO': PAMENT_PERIOD_NO,
      'expirePeriod': expirePeriod,
      'ID_facility': ID_facility,
      'AllowInviceWithFlag': AllowInviceWithFlag,
      'closeVisitWithoutImg': closeVisitWithoutImg,

      



    };
  }
}