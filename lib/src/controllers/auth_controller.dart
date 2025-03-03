import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/screens/home_screen.dart';
import 'package:notes_app/src/screens/login_screen.dart';
import 'package:notes_app/src/screens/registration_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  var isLoading = false.obs; // for loading indicator

  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    //ever(user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

//User Registration
  Future<void> userRegistration({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      isLoading(true);
      //creating user
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 3));
      final user = userCredential.user;

      // Store user additional information in fireStore
      await _firebaseFireStore.collection('user').doc(user?.uid).set({
        'username': username,
        'email': email,
        'phone': phone,
        'uid': user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }

  //Login User
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }

  // Logout User
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get Current User's Data
  Future<DocumentSnapshot?> getUserData() async {
    if (user.value != null) {
      return await _firebaseFireStore
          .collection('users')
          .doc(user.value!.uid)
          .get();
    }
    return null;
  }
}
