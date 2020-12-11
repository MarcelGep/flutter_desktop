import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_desktop/customer.dart';

class DatabaseHelper {
  static CollectionReference _customers =
      FirebaseFirestore.instance.collection('customers');

  static addCustomer(Customer customer) {
    DocumentReference ref = _customers.doc();

    Map<String, dynamic> data = {
      "id": ref.id,
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

    ref.set(data);
  }

  static Future<void> deleteCustomer(Customer customer) {
    return _customers
        .doc(customer.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static Stream<List<Customer>> getCustomerStream() {
    Query _sortCustomers = FirebaseFirestore.instance
        .collection("customers")
        .orderBy('name', descending: false);
    Stream<QuerySnapshot> stream = _sortCustomers.snapshots();
    return stream.map((qShot) =>
        qShot.docs.map((doc) => Customer.fromMap(doc.data())).toList());
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

  // static Future<List<Customer>> getCustomerData() async {
  //   QuerySnapshot qShot = await _sortCustomers.get();
  //   return qShot.docs.map((doc) => Customer.fromMap(doc.data())).toList();
  // }
}
