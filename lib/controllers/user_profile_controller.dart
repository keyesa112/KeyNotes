import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;
  var isLoggedIn = false.obs;

  void setUserProfile(String name, String mail) {
    fullName.value = name;
    email.value = mail;
    isLoggedIn.value = true;
  }

  void clearUserProfile() {
    fullName.value = '';
    email.value = '';
    isLoggedIn.value = false;
  }

  void logout() {}
}
