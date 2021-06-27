import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<UserCredential> signInGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount user = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication auth = await user.authentication;

  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: auth.accessToken,
    idToken: auth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
