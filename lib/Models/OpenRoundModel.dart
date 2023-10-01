class OpenRoundModel {
  var manno;
  var englishName;
  var roundType;   //0 normal
  var employeeType;   //0 normal
  var custId;
  var starttime;
  var endtime;
  var status;  // 0 => start // 1 => end

  OpenRoundModel(
      {
        this.manno,
        this.englishName,
        this.roundType,
        this.employeeType,
        this.custId,
        this.starttime,
        this.endtime,
        this.status
      });

  OpenRoundModel.fromJson(Map<String, dynamic> json) {
    manno = json['manno'];
    englishName = json['englishName'];
    roundType = json['roundType'];
    employeeType = json['employeeType'];
    custId = json['custId'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manno'] = this.manno.toString();
    data['englishName'] = this.englishName.toString();
    data['roundType'] = this.roundType.toString();
    data['employeeType'] = this.employeeType.toString();
    data['custId'] = this.custId.toString();
    data['starttime'] = this.starttime.toString();
    data['endtime'] = this.endtime.toString();
    data['status'] = this.status.toString();

    return data;
  }
}