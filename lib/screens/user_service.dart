import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp0/models/user.dart';

class UserService {
  
  Future<void> saveCurrentUser(User user) async {
    final sp = await SharedPreferences.getInstance();
    
    await sp.setString("current_user_email", user.email ?? "");
    await sp.setString("current_user_name", user.username ?? "");
    await sp.setString("current_user_password", user.password ?? "");
    await sp.setString("current_user_gender", user.gender ?? "");
    
    print("User Saved Successfully");
  }

  Future<User> getCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    
    User u = User();
    u.email = sp.getString("current_user_email");
    u.username = sp.getString("current_user_name");
    u.gender = sp.getString("current_user_gender");
    
    print("User Retrieved: ${u.username}");
    return u;
  }

  Future<void> clearCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove("current_user_email");
    await sp.remove("current_user_name");
    await sp.remove("current_user_gender");

  }
}