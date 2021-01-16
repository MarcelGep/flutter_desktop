import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/models/article.dart';
import 'package:flutter_desktop/models/customer.dart';
import 'package:flutter_desktop/models/users.dart';
import 'package:flutter_desktop/widgets/article_list.dart';

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

  static Future<User> getUserData() async {
    String userId = AuthHelper.getCurrentUserId();
    DocumentSnapshot snapshot = await _users.doc(userId).get();
    return new User.fromJson(userId, snapshot.data());
  }

  // Customers
  static addRandomCustomer() {
    var faker = new Faker();
    Customer newCustomer = new Customer(
        null,
        faker.internet.userName(),
        faker.person.name(),
        "Muster Str. 12",
        "89323",
        "Musterstadt",
        "0123456789",
        "0123456789",
        faker.internet.email(),
        "www." + faker.internet.userName() + ".de");

    DatabaseHelper.addCustomer(newCustomer);
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

  static void updateCustomer(Customer customer) {
    _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('customers')
        .doc(customer.id)
        .update(customer.toMap());
  }

  // Articles
  static Stream<List<Article>> getArticleStream() {
    Query _sortArticles = _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('articles')
        .orderBy('name', descending: false);
    Stream<QuerySnapshot> stream = _sortArticles.snapshots();
    return stream.map((qShot) =>
        qShot.docs.map((doc) => Article.fromMap(doc.data())).toList());
  }

  static addArticle(Article article) {
    DocumentReference articleRef =
        _users.doc(AuthHelper.getCurrentUserId()).collection('articles').doc();

    Map<String, dynamic> data = {
      "id": articleRef.id,
      "name": article.name,
      "price": article.price,
      "amount": article.amount,
      "unit": article.unit
    };

    articleRef
        .set(data)
        .catchError((error) => print("Failed to add article: $error"));
  }

  static deleteArticle(Article article) {
    _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('articles')
        .doc(article.id)
        .delete()
        .catchError((error) => print("Failed to delete article: $error"));
  }

  static void updateArticle(Article article) {
    _users
        .doc(AuthHelper.getCurrentUserId())
        .collection('articles')
        .doc(article.id)
        .update(article.toMap());
  }
}
