class Customer {
  String id;
  String name;
  String contact;
  String street;
  String zip;
  String location;
  String phone;
  String fax;
  String email;
  String web;

  Customer(this.id, this.name, this.contact, this.street, this.zip,
      this.location, this.phone, this.fax, this.email, this.web);

  Customer.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.contact = obj['contact'];
    this.street = obj['street'];
    this.zip = obj['zip'];
    this.location = obj['location'];
    this.phone = obj['phone'];
    this.fax = obj['fax'];
    this.email = obj['email'];
    this.web = obj['web'];
  }

  Map<String, dynamic> toMap() {
    var obj = new Map<String, dynamic>();
    obj['id'] = id;
    obj['name'] = name;
    obj['contact'] = contact;
    obj['street'] = street;
    obj['zip'] = zip;
    obj['location'] = location;
    obj['phone'] = phone;
    obj['fax'] = fax;
    obj['email'] = email;
    obj['web'] = web;
    return obj;
  }

  String get getId => id;

  set setId(String id) => this.id = id;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getContact => contact;

  set setContact(String contact) => this.contact = contact;

  String get getStreet => street;

  set setStreet(String street) => this.street = street;

  String get getZip => zip;

  set setZip(String zip) => this.zip = zip;

  String get getLocation => location;

  set setLocation(String location) => this.location = location;

  String get getPhone => phone;

  set setPhone(String phone) => this.phone = phone;

  String get getFax => fax;

  set setFax(String fax) => this.fax = fax;

  String get getEmail => email;

  set setEmail(String email) => this.email = email;

  String get getWeb => web;

  set setWeb(String web) => this.web = web;
}
