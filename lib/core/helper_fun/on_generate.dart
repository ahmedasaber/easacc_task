import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/signIn_view.dart';
import '../../features/settings/presentation/views/settings_view.dart';
import '../../features/settings/presentation/views/webview_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    case SettingsView.routeName:
      return MaterialPageRoute(builder: (context) => const SettingsView());
    case WebviewScreen.routeName:
      return MaterialPageRoute(builder: (context) => WebviewScreen(url: settings.arguments as String,));
   default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}