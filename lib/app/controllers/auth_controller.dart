import 'dart:convert';

import 'package:get/get.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  User? user;
  String? role;
  var isAuthenticated = false;
  final supabaseService = Get.find<SupabaseService>();
  final prefs = Get.find<SharedPreferences>();
  Future<User?> login(String email, String password) async {
    user = await supabaseService.signIn(
      email,
      password,
    );
    if (user != null) {
      role = await supabaseService.getRole(user!.id);
      isAuthenticated = true;
      prefs.setString("user", jsonEncode(user?.toJson()));
      prefs.setString("role", jsonEncode(role));
    }
    return user;
  }

  Future<void> logout() async {
    await supabaseService.signOut();
    await prefs.remove("user");
    await prefs.remove("role");
    isAuthenticated = false;
  }

  bool hasRequiredRole(List<String> requiredRoles) {
    if (requiredRoles.isEmpty) return true;
    return requiredRoles.contains(role);
  }

  void loadInfos() {
    final userString = prefs.getString("user");
    if (userString != null) {
      final userJson = jsonDecode(userString);
      user = User.fromJson(userJson);
      role = jsonDecode(prefs.getString("role")!);
      isAuthenticated = true;
    }
  }
}
