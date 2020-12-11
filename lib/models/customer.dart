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
}
