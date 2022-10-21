import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../storage/cache_keys.dart';

class UserModel {
  final String name;
  final String email;

  const UserModel({required this.name, required this.email});

  Map<String, dynamic> toMap() => {'name': name, 'email': email};

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(name: map['name'], email: map['email']);

  static Future<UserModel> fromFirebase(UserCredential credential) async {
    final userDataReference = await FirebaseFirestore.instance.collection('data').doc(credential.user!.uid).get();
    final userData = userDataReference.data()!;
    return UserModel.fromMap(userData);
  }

  static Future<UserModel> fromLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    final userData = json.decode(await box.get(CacheKeys.userData));
    return UserModel.fromMap(userData);
  }

  Future<void> storeUserInFirebase(UserCredential credential) async {
    await FirebaseFirestore.instance.collection('data').doc(credential.user!.uid).set(toMap());
  }

  Future<void> storeUserInLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    await box.put(CacheKeys.userData, json.encode(toMap()));
  }

  static Future<bool> userExistsInFirebase(UserCredential credential) async {
    final userDataReference = await FirebaseFirestore.instance.collection('data').doc(credential.user!.uid).get();
    final userData = userDataReference.data();
    return userData != null;
  }

  static Future<bool> userExistsInLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    return box.containsKey(CacheKeys.userData);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.name == name && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
