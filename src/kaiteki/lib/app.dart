import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kaiteki/account_manager.dart';
import 'package:kaiteki/app_colors.dart';
import 'package:kaiteki/fediverse/api/definitions/definitions.dart';
import 'package:kaiteki/preferences/preference_container.dart';
import 'package:kaiteki/theming/app_themes/default_app_themes.dart';
import 'package:kaiteki/theming/app_themes/material_app_theme.dart';
import 'package:kaiteki/theming/theme_container.dart';
import 'package:kaiteki/ui/screens/account_required_screen.dart';
import 'package:kaiteki/ui/screens/add_account_screen.dart';
import 'package:kaiteki/ui/screens/auth/login_screen.dart';
import 'package:kaiteki/ui/screens/main_screen.dart';
import 'package:kaiteki/ui/screens/manage_accounts_screen.dart';
import 'package:kaiteki/ui/screens/settings/about_screen.dart';
import 'package:kaiteki/ui/screens/settings/customization/customization_settings_screen.dart';
import 'package:kaiteki/ui/screens/settings/debug/shared_preferences_screen.dart';
import 'package:kaiteki/ui/screens/settings/debug_screen.dart';
import 'package:kaiteki/ui/screens/settings/filtering/filtering_screen.dart';
import 'package:kaiteki/ui/screens/settings/filtering/sensitive_post_filtering_screen.dart';
import 'package:kaiteki/ui/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

class KaitekiApp extends StatefulWidget {
  const KaitekiApp({
    required this.accountContainer,
    required this.notifications,
    required this.preferences,
  });

  @override
  _KaitekiAppState createState() => _KaitekiAppState();

  final PreferenceContainer preferences;
  final AccountManager accountContainer;
  final FlutterLocalNotificationsPlugin? notifications;
}

class _KaitekiAppState extends State<KaitekiApp> {
  late ThemeContainer _themeContainer;

  @override
  void initState() {
    _themeContainer = ThemeContainer(DefaultAppThemes.lightAppTheme);

    super.initState();
  }

  // TODO: (code quality) Move MultiProvider and Builder to "main.dart" instead of "app.dart".
  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeContainer),
        ChangeNotifierProvider.value(value: widget.accountContainer),
        ChangeNotifierProvider.value(value: widget.preferences),
      ],
      child: Builder(
        builder: (context) {
          // TODO: (code quality) listen to only a subset of preferences, to reduce unnecessary root rebuilds.
          var preferences = Provider.of<PreferenceContainer>(context);
          return MaterialApp(
            title: "Kaiteki",
            theme: ThemeData.from(
              colorScheme: DefaultAppThemes.lightScheme,
            ),
            darkTheme: ThemeData.from(
              colorScheme: DefaultAppThemes.darkScheme,
            ),
            color: AppColors.kaitekiDarkBackground.shade900,
            themeMode: preferences.get().theme,
            initialRoute: "/",
            routes: {
              "/": (_) {
                return Builder(
                  builder: (context) {
                    if (Provider.of<AccountManager>(context).loggedIn) {
                      return MainScreen();
                    } else {
                      return AccountRequiredScreen();
                    }
                  },
                );
              },
              "/accounts": (_) => const ManageAccountsScreen(),
              "/accounts/add": (_) => const AddAccountScreen(),
              "/about": (_) => AboutScreen(),
              "/settings": (_) => SettingsScreen(),
              "/settings/customization": (_) =>
                  const CustomizationSettingsScreen(),
              "/settings/filtering": (_) => FilteringScreen(),
              "/settings/filtering/sensitivePosts": (_) =>
                  const SensitivePostFilteringScreen(),
              "/settings/debug": (_) => const DebugScreen(),
              "/settings/debug/preferences": (_) =>
                  const SharedPreferencesScreen(),
            },
            onGenerateRoute: _generateRoute,
          );
        },
      ),
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    var loginPrefix = "/login/";

    if (settings.name!.startsWith(loginPrefix)) {
      var id = settings.name!.substring(loginPrefix.length);
      var definition = ApiDefinitions.definitions.firstWhere((o) => o.id == id);

      final screen = LoginScreen(
        image: AssetImage(definition.theme.iconAssetLocation),
        theme: _makeTheme(
          definition.theme.backgroundColor,
          definition.theme.primaryColor,
        ),
        onLogin: definition.createAdapter().login,
        type: definition.type,
      );

      return MaterialPageRoute(builder: (_) => screen);
    }

    return null;
  }

  ThemeData _makeTheme(Color background, Color foreground) {
    return ThemeData.from(
      colorScheme: ColorScheme.dark(
        background: background,
        surface: background,
        primary: foreground,
        secondary: foreground,
        primaryVariant: foreground,
        secondaryVariant: foreground,
      ),
    ).copyWith(
      buttonTheme: ButtonThemeData(
        buttonColor: foreground,
      ),
    );
  }
}
