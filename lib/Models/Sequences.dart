class Sequences {




  String? salesOrderMax;

  Sequences({
    this.salesOrderMax,
  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory Sequences.fromMap(Map<String, dynamic> map) {
    return Sequences(

      salesOrderMax: map['salesOrderMax'],


    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'salesOrderMax': salesOrderMax,

    };
  }

  Sequences.fromJson(Map<String, dynamic> json) {
    salesOrderMax = json['salesOrderMax'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOrderMax'] = this.salesOrderMax;

    return data;
  }


}
