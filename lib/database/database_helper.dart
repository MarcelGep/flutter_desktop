import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/models/customer.dart';
import 'package:flutter_desktop/models/users.dart';

class DatabaseHelper {
  static CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  static addUserData(String userName) {
    Map<String, String> userData = AuthHelper.getCurrentUser();

    String displayName = userData['name'];
    String email = userData['email'];

    if ((displayName == null || displayName.isEmpty) && userName != null) {
      displayName = userName;
    }

    Map<String, dynamic> data = {"displayName": displayName, "email": email};

    _users.doc(AuthHelper.getCurrentUserId()).set(data);
  }

  // static User getUserData(String userId) {
  //   _users.doc(userId).get().then((snapshot) {
  //     User user = new User.fromJson(userId, snapshot.data());
  //     return user;
  //   });
  //   return null;
  // }

  static addCustomer(Customer customer) {
    DocumentReference customerRef =
        _users.doc(AuthHelper.getCurrentUserId()).collection('customers').doc();

    Map<String, dynamic> data = {
      "id": customerRef.id,
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

    customerRef
        .set(data)
        .catchError((error) => print("Failed to add customer: $error"));
  }

  static deleteCustomer(Customer customer) {
    _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('customers')
        .doc(customer.id)
        .delete()
        .catchError((error) => print("Failed to delete customer: $error"));
  }

  static Stream<List<Customer>> getCustomerStream() {
    Query _sortCustomers = _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('customers')
        .orderBy('name', descending: false);
    Stream<QuerySnapshot> stream = _sortCustomers.snapshots();
    return stream.map((qShot) =>
        qShot.docs.map((doc) => Customer.fromMap(doc.data())).toList());
  }

  static void updateCustomer(Customer customer) {
    _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('customers')
        .doc(customer.id)
        .update(customer.toMap());
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
