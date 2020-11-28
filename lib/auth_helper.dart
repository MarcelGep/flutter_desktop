import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static signInWithEmail({String email, String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return res.user;
  }

  static signUpWithEmail({String email, String password}) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return res.user;
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
    _googleSignIn.signOut();
    return _auth.signOut();
  }
}
