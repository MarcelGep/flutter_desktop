import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_desktop/customer.dart';

class DatabaseHelper {
  static CollectionReference _customers =
      FirebaseFirestore.instance.collection('customers');

  static addCustomerData(Customer customer) {
    Map<String, dynamic> data = {
      "name": customer.name,
      "contact": customer.contact,
      "street": customer.street,
      "zip": customer.zip,
      "location": customer.location,
      "phone": customer.phone,
      "fax": customer.fax,
      "email": customer.email,
      "web": customer.web
    };

    _customers.add(data);
  }

  // static Future<void> readCustomerData() {
  //   _customers.get().then(
  //         (QuerySnapshot querySnapshot) => {
  //           querySnapshot.docs.forEach(
  //             (doc) {
  //               print(doc["contact"]);
  //             },
  //           )
  //         },
  //       );
  // }

  static Future<void> deleteUser() {
    return _customers
        .doc(_customers.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static Stream<List<Customer>> getCustomerStream() {
    Stream<QuerySnapshot> stream = _customers.snapshots();
    return stream.map((qShot) =>
        qShot.docs.map((doc) => Customer.fromMap(doc.data())).toList());
  }

  static Future<List<Customer>> getCustomerData() async {
    QuerySnapshot qShot = await _customers.get();
    return qShot.docs.map((doc) => Customer.fromMap(doc.data())).toList();
  }
}
