import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info/package_info.dart';

import '../models/customer.dart';

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveCustomer(Customer customer) async {
    Map<String, dynamic> customerData = {
      "name": customer.name,
      "contact": customer.contact,
      "street": customer.street,
      "location": customer.location,
      "phone": customer.phone,
      "email": customer.email,
      "web": customer.web,
    };
  }

  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "user",
      "buildNumber": buildNumber,
    };

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "buildNumber": buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;

    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": "android",
        "model": deviceInfo.model,
        "device": deviceInfo.device
      };
    }

    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "platform": "ios",
        "model": deviceInfo.model,
        "device": deviceInfo.name,
      };
    }

    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "update_at": nowMs,
        "uninstalled": false,
      });
    } else {
      await deviceRef.set({
        "created_at": nowMs,
        "updated_at": nowMs,
        "uninstalled": false,
        "id": deviceId,
        "device_info": deviceData
      });
    }
  }
}
