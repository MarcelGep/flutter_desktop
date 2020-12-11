import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Stream<User> get authStateChanges {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('No user is signed in!');
      } else {
        String email = user.email;
        print('User $email is signed in!');
      }
    });
    return _auth.authStateChanges();
  }

  static Future<User> signInWithEmail({String email, String password}) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  static Future<String> signInWithEmail2(
      {String email, String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user.uid;
    } on FirebaseAuthException catch (e) {
      print("Sign in error: " + e.code);
      return e.code;
    }
  }

  static Future<String> signUpWithEmail({String email, String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user.uid;
    } on FirebaseAuthException catch (e) {
      print("Sign in error: " + e.code);
      return e.code;
    }
  }

  static signInWithGoogle() async {
    final GoogleSignInAccount acc = await _googleSignIn.signIn();
    final GoogleSignInAuthentication auth = await acc.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    final UserCredential res = await _auth.signInWithCredential(credential);
    final User user = res.user;

    if (res.user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: ' + user.displayName);

      return user;
    }

    return null;
  }

  static logOut() {
    //_googleSignIn.signOut();
    return _auth.signOut();
  }
}
