import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/camera/camera_page.dart';
import '../../presentation/camera/photo_review_page.dart';
import '../../presentation/onboarding/onboarding_page.dart';
import '../../presentation/settings/settings_page.dart';
import '../../presentation/splash/splash_page.dart';
import 'app_router_names.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRouterNames.settings,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRouterNames.splash,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: AppRouterNames.onboarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: AppRouterNames.camera,
        builder: (context, state) => const CameraPage(),
      ),
      GoRoute(
        path: AppRouterNames.photoPreview,
        builder: (context, state) {
          final XFile? image = state.extra as XFile?;
          return PhotoPreviewPage(image: image);
        },
      ),
      GoRoute(
        path: AppRouterNames.settings,
        builder: (context, state) => SettingsPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
