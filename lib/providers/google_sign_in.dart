import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final ApiManager apiManager = ApiManager();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User authUser;
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _auth.signInWithCredential(credential);
      authUser = _auth.currentUser;
      bool userExists =
          await apiManager.getUserByEmail(authUser.email.toString()) != null;
      if (!userExists) {
        await apiManager.addUser(IUser(
            name: authUser.displayName.split(' ')[0].toString(),
            lastname: authUser.displayName.split(' ')[1].toString(),
            email: authUser.email.toString(),
            favoriteRecipesKeys: [""]));
      }
      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
