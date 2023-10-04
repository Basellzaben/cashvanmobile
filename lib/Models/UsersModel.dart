class UsersModel {
  var id;
  var arabicName;
  var englishName;
  var manType;
  var manSupervisor;
  var alternativeMan;
  var branchNo;
  var manStatus;
  var email;
  var mobileNo;
  var loginName;
  var basicSalary;
  var carId;
  var password;
  var cashComm;
  var creditComm;
  var quta;
  var sales2;
  var state;
  var year;
  var country;
  var city;
  var area;
  var type;
  var note;
  var dis;
  var storeNo;
  var mobileNo2;
  var manImage;
  var imagePath;
  var maxDiscount;
  var maxBouns;
  var fullName;
  var manMaterial;
  var manRegion;
  var opiningBalanceVacation;
  var balanceVacation;
  var equationId;
  var subAgent;
  var customerName;
  var items;
  var salesAccNo;
  var receiptVType;
  var salesVType;
  var retSalesVType;
  var cashAccNo;
  var vType;
  var supervisor;
  var allowLoginOutside;
  var rangeLogin;
  var Acc_Num;

  UsersModel(
      {this.id,
        this.arabicName,
        this.englishName,
        this.manType,
        this.manSupervisor,
        this.alternativeMan,
        this.branchNo,
        this.manStatus,
        this.email,
        this.mobileNo,
        this.loginName,
        this.basicSalary,
        this.carId,
        this.password,
        this.cashComm,
        this.creditComm,
        this.quta,
        this.sales2,
        this.state,
        this.year,
        this.country,
        this.city,
        this.area,
        this.type,
        this.note,
        this.dis,
        this.storeNo,
        this.mobileNo2,
        this.manImage,
        this.imagePath,
        this.maxDiscount,
        this.maxBouns,
        this.fullName,
        this.manMaterial,
        this.manRegion,
        this.opiningBalanceVacation,
        this.balanceVacation,
        this.equationId,
        this.subAgent,
        this.customerName,
        this.items,
        this.salesAccNo,
        this.receiptVType,
        this.salesVType,
        this.retSalesVType,
        this.cashAccNo,
        this.vType,
        this.supervisor,
        this.allowLoginOutside,
        this.rangeLogin,
        this.Acc_Num});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'arabicName': arabicName,
      'englishName': englishName,
      'manType': manType,
      'manSupervisor': manSupervisor,
      'alternativeMan': alternativeMan,
      'branchNo': branchNo,
      'manStatus': manStatus,
      'email': email,
      'mobileNo': mobileNo,
      'loginName': loginName,
      'basicSalary': basicSalary,
      'carId': carId,
      'password': password,
      'cashComm': cashComm,
      'creditComm': creditComm,
      'quta': quta,
      'sales2': sales2,
      'state': state,
      'year': year,
      'country': country,
      'city': city,
      'area': area,
      'type': type,
      'note': note,
      'dis': dis,
      'storeNo': storeNo,
      'mobileNo2': mobileNo2,
      'manImage': manImage,
      'imagePath': imagePath,
      'maxDiscount': maxDiscount,
      'maxBouns': maxBouns,
      'fullName': fullName,
      'manMaterial': manMaterial,
      'manRegion': manRegion,
      'opiningBalanceVacation': opiningBalanceVacation,
      'balanceVacation': balanceVacation,
      'equationId': equationId,
      'subAgent': subAgent,
      'customerName': customerName,
      'items': items,
      'salesAccNo': salesAccNo,
      'receiptVType': receiptVType,
      'salesVType': salesVType,
      'retSalesVType': retSalesVType,
      'cashAccNo': cashAccNo,
      'vType': vType,
      'supervisor': supervisor,
      'allowLoginOutside': allowLoginOutside,
      'rangeLogin': rangeLogin,
      'Acc_Num': Acc_Num,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      arabicName: map['arabicName'],
      englishName: map['englishName'],
      manType: map['manType'],
      manSupervisor: map['manSupervisor'],
      alternativeMan: map['alternativeMan'],
      branchNo: map['branchNo'],
      manStatus: map['manStatus'],
      email: map['email'],
      mobileNo: map['mobileNo'],
      loginName: map['loginName'],
      basicSalary: map['basicSalary'],
      carId: map['carId'],
      password: map['password'],
      cashComm: map['cashComm'],
      creditComm: map['creditComm'],
      quta: map['quta'],
      sales2: map['sales2'],
      state: map['state'],
      year: map['year'],
      country: map['country'],
      city: map['city'],
      area: map['area'],
      type: map['type'],
      note: map['note'],
      dis: map['dis'],
      storeNo: map['storeNo'],
      mobileNo2: map['mobileNo2'],
      manImage: map['manImage'],
      imagePath: map['imagePath'],
      maxDiscount: map['maxDiscount'],
      maxBouns: map['maxBouns'],
      fullName: map['fullName'],
      manMaterial: map['manMaterial'],
      manRegion: map['manRegion'],
      opiningBalanceVacation: map['opiningBalanceVacation'],
      balanceVacation: map['balanceVacation'],
      equationId: map['equationId'],
      subAgent: map['subAgent'],
      customerName: map['customerName'],
      items: map['items'],
      salesAccNo: map['salesAccNo'],
      receiptVType: map['receiptVType'],
      salesVType: map['salesVType'],
      retSalesVType: map['retSalesVType'],
      cashAccNo: map['cashAccNo'],
      vType: map['vType'],
      supervisor: map['supervisor'],
      allowLoginOutside: map['allowLoginOutside'],
      rangeLogin: map['rangeLogin'],
      Acc_Num: map['Acc_Num'],
    );
  }


  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    manType = json['manType'];
    manSupervisor = json['manSupervisor'];
    alternativeMan = json['alternativeMan'];
    branchNo = json['branchNo'];
    manStatus = json['manStatus'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    loginName = json['loginName'];
    basicSalary = json['basicSalary'];
    carId = json['carId'];
    password = json['password'];
    cashComm = json['cashComm'];
    creditComm = json['creditComm'];
    quta = json['quta'];
    sales2 = json['sales2'];
    state = json['state'];
    year = json['year'];
    country = json['country'];
    city = json['city'];
    area = json['area'];
    type = json['type'];
    note = json['note'];
    dis = json['dis'];
    storeNo = json['storeNo'];
    mobileNo2 = json['mobileNo2'];
    manImage = json['manImage'];
    imagePath = json['imagePath'];
    maxDiscount = json['maxDiscount'];
    maxBouns = json['maxBouns'];
    fullName = json['fullName'];
    manMaterial = json['manMaterial'];
    manRegion = json['manRegion'];
    opiningBalanceVacation = json['opiningBalanceVacation'];
    balanceVacation = json['balanceVacation'];
    equationId = json['equationId'];
    subAgent = json['subAgent'];
    customerName = json['customerName'];
    items = json['items'];
    salesAccNo = json['salesAccNo'];
    receiptVType = json['receiptVType'];
    salesVType = json['salesVType'];
    retSalesVType = json['retSalesVType'];
    cashAccNo = json['cashAccNo'];
    vType = json['vType'];
    supervisor = json['supervisor'];
    allowLoginOutside = json['allowLoginOutside'];
    rangeLogin = json['rangeLogin'];
    Acc_Num = json['acc_Num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['arabicName'] = this.arabicName.toString();
    data['englishName'] = this.englishName.toString();
    data['manType'] = this.manType.toString();
    data['manSupervisor'] = this.manSupervisor.toString();
    data['alternativeMan'] = this.alternativeMan.toString();
    data['branchNo'] = this.branchNo.toString();
    data['manStatus'] = this.manStatus.toString();
    data['email'] = this.email.toString();
    data['mobileNo'] = this.mobileNo.toString();
    data['loginName'] = this.loginName.toString();
    data['basicSalary'] = this.basicSalary.toString();
    data['carId'] = this.carId.toString();
    data['password'] = this.password.toString();
    data['cashComm'] = this.cashComm.toString();
    data['creditComm'] = this.creditComm.toString();
    data['quta'] = this.quta.toString();
    data['sales2'] = this.sales2.toString();
    data['state'] = this.state.toString();
    data['year'] = this.year.toString();
    data['country'] = this.country.toString();
    data['city'] = this.city.toString();
    data['area'] = this.area.toString();
    data['type'] = this.type.toString();
    data['note'] = this.note.toString();
    data['dis'] = this.dis.toString();
    data['storeNo'] = this.storeNo.toString();
    data['mobileNo2'] = this.mobileNo2.toString();
    data['manImage'] = this.manImage.toString();
    data['imagePath'] = this.imagePath.toString();
    data['maxDiscount'] = this.maxDiscount.toString();
    data['maxBouns'] = this.maxBouns.toString();
    data['fullName'] = this.fullName.toString();
    data['manMaterial'] = this.manMaterial.toString();
    data['manRegion'] = this.manRegion.toString();
    data['opiningBalanceVacation'] = this.opiningBalanceVacation.toString();
    data['balanceVacation'] = this.balanceVacation.toString();
    data['equationId'] = this.equationId.toString();
    data['subAgent'] = this.subAgent.toString();
    data['customerName'] = this.customerName.toString();
    data['items'] = this.items.toString();
    data['salesAccNo'] = this.salesAccNo.toString();
    data['receiptVType'] = this.receiptVType.toString();
    data['salesVType'] = this.salesVType.toString();
    data['retSalesVType'] = this.retSalesVType.toString();
    data['cashAccNo'] = this.cashAccNo.toString();
    data['vType'] = this.vType.toString();
    data['supervisor'] = this.supervisor.toString();
    data['allowLoginOutside'] = this.allowLoginOutside.toString();
    data['rangeLogin'] = this.rangeLogin.toString();
    data['acc_Num'] = this.Acc_Num.toString();
    return data;


  }
}