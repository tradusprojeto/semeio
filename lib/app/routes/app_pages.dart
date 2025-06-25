import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:semeio_app/app/bindings/adm_edit_bindings.dart';
import 'package:semeio_app/app/bindings/adm_view_bindings.dart';
import 'package:semeio_app/app/bindings/home_bindings.dart';
import 'package:semeio_app/app/bindings/login_bindings.dart';
import 'package:semeio_app/app/bindings/send_audio_bindings.dart';
import 'package:semeio_app/app/bindings/map_page_bindings.dart';
import 'package:semeio_app/app/bindings/user_edit_audio_bindings.dart';
import 'package:semeio_app/app/bindings/user_home_bindings.dart';
import 'package:semeio_app/app/bindings/user_login_bindings.dart';
import 'package:semeio_app/app/bindings/user_password_reset_bindings.dart';
import 'package:semeio_app/app/bindings/user_password_update_bindings.dart';
import 'package:semeio_app/app/bindings/user_signup_bindings.dart';
import 'package:semeio_app/app/core/middlewares/auth_middleware';
import 'package:semeio_app/app/ui/pages/desktop/adm_edit_audio.dart';
import 'package:semeio_app/app/ui/pages/desktop/adm_home_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/adm_login_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/adm_view_audio.dart';
import 'package:semeio_app/app/ui/pages/desktop/forbidden_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/send_audio_desktop.dart';
import 'package:semeio_app/app/ui/pages/desktop/map_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_edit_audio_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_home_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_login_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_password_reset_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_password_update_page.dart';
import 'package:semeio_app/app/ui/pages/desktop/user_signup_page.dart';
import 'package:semeio_app/app/ui/pages/mobile/home_send_audio.dart';
part "./app_routes.dart";

class AppPages {
  final List<GetPage> pages = [
    GetPage(
        name: Routes.admHome,
        page: () => const AdmHomePage(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["admin"])
        ],
        binding: HomeBindings()),
    GetPage(
        name: Routes.userHome,
        page: () => const UserHomePage(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["user"])
        ],
        binding: UserHomeBindings()),
    GetPage(
        name: Routes.login,
        page: () => const AdmLoginPage(),
        binding: LoginBindings()),
    GetPage(
        name: Routes.userLogin,
        page: () => const UserLoginPage(),
        binding: UserLoginBindings()),
    GetPage(
        name: Routes.userPasswordReset,
        page: () => const UserPasswordResetPage(),
        binding: UserPasswordResetBindings()),
    GetPage(
        name: Routes.userPasswordUpdate,
        page: () => const UserPasswordUpdatePage(),
        binding: UserPasswordUpdateBindings()),
    GetPage(
        name: Routes.mapPage,
        page: () => const MapPage(),
        binding: MapPageBindings()),
    GetPage(name: Routes.createAudio, page: () => const SendAudio()),
    GetPage(
        name: Routes.desktopSendAudio,
        page: () => const SendAudioDesktop(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["admin", "user"])
        ],
        binding: SendAudioBindings()),
    GetPage(
        name: Routes.admViewAudio,
        page: () => const AdmViewAudio(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["admin"])
        ],
        binding: AdmViewBindings()),
    GetPage(
        name: Routes.admEditAudio,
        page: () => const AdmEditAudio(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["admin"])
        ],
        binding: AdmEditBindings()),
    GetPage(
        name: Routes.userSignUp,
        page: () => const UserSignUpPage(),
        binding: UserSignUpBindings()),
    GetPage(
        name: Routes.userEditAudio,
        page: () => const UserEditAudioPage(),
        middlewares: [
          AuthMiddleware(requiredRoles: ["user"])
        ],
        binding: UserEditAudioBindings()),
    GetPage(name: Routes.forbidden, page: () => const ForbiddenPage())
  ];
}
