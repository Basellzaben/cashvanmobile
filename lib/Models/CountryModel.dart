class CountryModel {

  String? no;
  String? name;
  String? ename;
  String? target;
  String? namepe;
  String? namepa;
  String? parent;


  String? city;
  String? route;
  String? father;
  String? branch;


  CountryModel({
    this.no,
    this.name,
    this.ename,
    this.target,
    this.namepe,
    this.namepa,
    this.parent,

    this.city,
    this.route,
    this.father,
    this.branch,

  });

  // Factory constructor to create a ManLogTransModel object from a map
  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(

      no: map['no'],
      name: map['name'],
      ename: map['ename'],
      target: map['target'],
      namepe: map['namepe'],
      namepa: map['namepa'],
      parent: map['parent'],

      city: map['city'],
      route: map['route'],
      father: map['father'],
      branch: map['branch'],

    );
  }

  // Convert a ManLogTransModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'name': name, // Convert DateTime to ISO 8601 string
      'ename': ename,
      'target': target,
      'namepe': namepe,
      'namepa': namepa,
      'parent': parent,

      'city': city,
      'route': route,
      'father': father,
      'branch': branch,

    };
  }

  CountryModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    name = json['name'];
    ename = json['ename'];
    target = json['target'];
    namepe = json['namepe'];
    namepa = json['bonus'];
    parent = json['parent'];

    city = json['city'];
    route = json['route'];
    father = json['father'];
    branch = json['branch'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['name'] = this.name;
    data['ename'] = this.ename;
    data['target'] = this.target;
    data['namepe'] = this.namepe;
    data['namepa'] = this.namepa;
    data['parent'] = this.parent;

    data['city'] = this.city;
    data['route'] = this.route;
    data['father'] = this.father;
    data['branch'] = this.branch;

    return data;
  }


}
