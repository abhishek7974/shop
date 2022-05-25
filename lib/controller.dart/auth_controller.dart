

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';


import '../view/screen/sign_up.dart';
import '../const.dart';
import '../provider/user.dart' as model;
import '../view/product_overview_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  
  //getter for flutter
  

void onReady(){
  super.onReady();
  _user = Rx<User?>(firebaseAuth.currentUser);
  _user.bindStream(firebaseAuth.authStateChanges());
  ever(_user, _setInitialScreen);
}

_setInitialScreen(User? user){
  if(user == null){
    Get.offAll(() => SignUpScreen());
  }
  else{
    Get.offAll(() => ProductOverviewScreen());
  }
}

  

  //register a user
  void registerUser(
      String username, String email, String password) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        // String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(name: username,email: email,uid: cred.user!.uid);
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
            }
        else{
           Get.snackbar(
        'error creating an account',
        'please enter all the fields'
      );
    }
  } catch (e) {
      Get.snackbar(
        'error creating an account',
        e.toString(),
      );
    }
  }
  void loginUser(String email, String password)async{
    try{
      if(email.isNotEmpty &&
          password.isNotEmpty){
            await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
            print('Login success');
          }
      else{
           Get.snackbar(
        'Error Logging In',
        'please enter all the fields'
      );
    }
        

    }catch(e){
      Get.snackbar(
        'error Logging In',
        e.toString(),
      );
    }
  }
}
