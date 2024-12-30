import 'package:get/get.dart';
import 'package:KeyNotes/model/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  // Variabel reactive untuk menyimpan informasi pengguna yang login
  Rx<User> currentUser = User(
      iduser: '', 
      user_fullname: '', 
      user_email: '', 
      user_nohp: '', 
      user_password: ''
    ).obs;

  void setUser(User user) {
    currentUser.value = user;
  }

  void logout() {
    // Hapus informasi pengguna yang login saat logout
    currentUser.value = User(
      iduser: '', 
      user_fullname: '', 
      user_email: '', 
      user_nohp: '',
      user_password: ''
    );
  }
}
