import 'package:edu_app/screens/home.dart';
import 'package:edu_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:uig/screens/home_screen.dart/home_screen.dart';
// import 'package:uig/screens/home_screen.dart/homescreen.dart';
// import 'package:uig/screens/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);

    //Rx - Observable Keyword - Continously Checking Variable Is Changing Or Not.
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => SplashScreen());
    } else {
      Get.offAll(() => Homepage());
    }
  }

  void signUp(
    String username,
    String password,
    String email,
  ) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Creating Account", "Please fill all fields");
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar("Success", "Logged in successfully");
      } else {
        Get.snackbar("Error Logging In", "Please enter your details correctly");
      }
    } catch (e) {
      Get.snackbar("Error logging in", e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  // Future<UserCredential> signInWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   if (kIsWeb) {
  //     await FirebaseAuth.instance.signInWithPopup(appleProvider);
  //   } else {
  //     await FirebaseAuth.instance.signInWithProvider(appleProvider);
  //   }
  // }
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent to $email");
    } catch (e) {
      String errorMessage =
          "An error occurred while sending the password reset email.";
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? "Unknown error";
      }
      Get.snackbar("Error", errorMessage);
      print("Error sending password reset email: $e");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
