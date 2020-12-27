class User {
  String id;
  String name;
  String email;

  User(this.id, this.name, this.email);

  User.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.email = obj['email'];
  }

  User.fromJson(this.id, Map data) {
    name = data['displayName'];
    email = data['email'];
  }

  Map<String, dynamic> toMap() {
    var obj = new Map<String, dynamic>();
    obj['id'] = id;
    obj['name'] = name;
    obj['email'] = email;
    return obj;
  }
}
