import 'package:easacc_task/features/auth/presentation/views/signIn_view.dart';
import 'package:easacc_task/features/settings/presentation/views/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/firebase_auth_service.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuthService().logOut();
            Navigator.pushNamedAndRemoveUntil(context, SignInView.routeName, (r)=>false);
          }, icon: Icon(Icons.logout, color: Colors.blueGrey,))
        ],
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        )
      ),
      body: SettingViewBody(),
    );
  }
}
