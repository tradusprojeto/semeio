import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semeio_app/app/bindings/login_bindings.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //await dotenv.load(fileName: "assets/.env");

  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs);

  // dotenv.env["SUPABASE_URL"]!,
  // dotenv.env["SUPABASE_API_KEY"]!

  await Supabase.initialize(
    url: const String.fromEnvironment("SUPABASE_URL"),
    debug: true,
    anonKey: const String.fromEnvironment("SUPABASE_API_KEY"),
    authOptions: FlutterAuthClientOptions(
      localStorage: SharedPreferencesLocalStorage(
        persistSessionKey: "persist-supabase-auth",
      ),
    ),
  );
  runApp(const SemeioApp());
}

class SemeioApp extends StatelessWidget {
  const SemeioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      debugShowCheckedModeBanner: false,
      title: "Semeio",
      initialRoute: Routes.login,
      getPages: AppPages().pages,
      initialBinding: LoginBindings(),
    );
  }
}
