import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer'; // for log()



class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //Obtain the auth details for the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      //Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log("Google authentication error: $error");
      return null;
    }
  }
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Success: Successfully sent reset email";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return("Error: Invalid Email Format");
      } else if (e.code == 'user-not-found') {
        return("Error: No user associated with this email.");
      } else {
        return("Error: An unknown error occured.");
      }
    }
    catch (error) {
      log("Error: Error while sending forgot password email.");
      return("Error: An unknown error occured.");
    }
  }
}

