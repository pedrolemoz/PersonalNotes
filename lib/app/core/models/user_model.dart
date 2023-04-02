import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../storage/cache_keys.dart';

class UserModel {
  final String name;
  final String email;
  final String userID;

  const UserModel({required this.name, required this.email, required this.userID});

  Map<String, dynamic> toMap() => {'name': name, 'email': email, 'userID': userID};

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        name: map['name'],
        email: map['email'],
        userID: map['userID'],
      );

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

  Future<void> storeUserInFirebase() async {
    await FirebaseFirestore.instance.collection('data').doc(userID).set(toMap());
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

  static Future<UserModel> loginWithCredentials(String email, String password) async {
    final authenticationService = FirebaseAuth.instance;
    final userCredential = await authenticationService.signInWithEmailAndPassword(email: email, password: password);
    final userModel = await UserModel.fromFirebase(userCredential);
    await userModel.storeUserInLocalStorage();
    return userModel;
  }

  static Future<UserModel> registerWithCredentials(String name, String email, String password) async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userModel = UserModel(name: name, email: email, userID: userCredential.user!.uid);
    await userModel.storeUserInFirebase();
    await userModel.storeUserInLocalStorage();

    return userModel;
  }

  static Future<UserModel> authWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    late UserModel userModel;

    if (await UserModel.userExistsInFirebase(userCredential)) {
      userModel = await UserModel.fromFirebase(userCredential);
    } else {
      userModel = UserModel(name: googleUser!.displayName!, email: googleUser.email, userID: userCredential.user!.uid);
      await userModel.storeUserInFirebase();
    }

    await userModel.storeUserInLocalStorage();

    return userModel;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.name == name && other.email == email && other.userID == userID;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ userID.hashCode;
}
