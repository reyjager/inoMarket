import 'package:hive/hive.dart';
import 'package:inomarket/model/user.dart';

class GlobalAuthService {
  static bool isLoggedIn() {
    Box<AppUser> appUserBox = Hive.box<AppUser>("current_user");
    AppUser? user = appUserBox.get('current');
    return user != null;
  }

  static AppUser loggedInUser() {
    Box<AppUser> appUserBox = Hive.box<AppUser>("current_user");
    AppUser? user = appUserBox.get('current');
    if (user != null) {
      return user;
    }
    throw Exception("NO_LOGGEDIN_USER");
  }

  static void logout() async {
    Box<AppUser> appUserBox = Hive.box<AppUser>("current_user");
    await appUserBox.delete('current');
  }
}
