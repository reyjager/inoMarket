// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> emailCheckInUsed({required String email}) async {
    try {
      List<String> signInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      print('Error checking email: ${e.message}');
      return false;
    }
  }

  static Future<bool?> getCurrentUserIsAdmin() async {
    try {
      // Get the current user ID
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        return null; // User is not signed in
      }

      // Reference to the Firestore users collection, getting only the 'isadmin' field
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        // Print the 'isadmin' field value before returning
        final isAdmin = userDoc.data()?['isadmin'] as bool?;
        print('isAdmin: $isAdmin');
        return isAdmin;
      } else {
        return null; // User document does not exist
      }
    } catch (e) {
      // Handle any errors that occur during the query
      print('Error fetching user isAdmin status: $e');
      return null;
    }
  }

  // Future<String?> registerWithEmailAndPhone({
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required Future<String> Function(String phone) sendOtpAndGetVerificationId,
  //   required Future<String> Function() getSmsCodeFromUser,
  // }) async {
  //   try {
  //     // Step 1: Create user with email/password
  //     UserCredential emailCredential =
  //         await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     User? user = emailCredential.user;

  //     if (user == null) return 'User creation failed.';

  //     // Step 2: Start phone verification
  //     String verificationId = await sendOtpAndGetVerificationId(phoneNumber);

  //     // Step 3: Wait for the user to enter the SMS code
  //     String smsCode = await getSmsCodeFromUser();

  //     // Step 4: Create PhoneAuthCredential
  //     PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsCode,
  //     );

  //     // Step 5: Link phone number to the created user
  //     await user.linkWithCredential(phoneCredential);

  //     return null; // success
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   } catch (e) {
  //     return 'An unexpected error occurred.';
  //   }
  // }
}
