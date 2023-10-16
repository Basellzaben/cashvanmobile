class UnitesModel{
  String? Unitno;
  String? UnitName;
  String? UnitEname;

  UnitesModel({
    required this.Unitno,
    required this.UnitName,
    required this.UnitEname,
  });

  UnitesModel.fromMap(Map<dynamic, dynamic> res)
      : Unitno = res["Unitno"].toString(),
        UnitName = res["UnitName"].toString(),
        UnitEname = res["UnitEname"].toString();

  Map<String, Object?> toMap() {
    return {
      'Unitno': Unitno,
      'UnitName': UnitName,
      'UnitEname': UnitEname,
    };
  }

  UnitesModel.fromJson(Map<String, dynamic> json) {
    Unitno = json['unitno'];
    UnitName = json['unitName'];
    UnitEname = json['unitEname'];

  }
  
}