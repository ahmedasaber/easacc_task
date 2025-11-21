import 'package:easacc_task/features/auth/presentation/views/widgets/signIn_view_body.dart';
import 'package:easacc_task/features/settings/presentation/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper_fun/error_snack_bar.dart';
import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../signin_cubit/signin_cubit.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInFailure) {
              showErrorBar(context, state.message);
            }
            if (state is SignInSuccess) {
              Navigator.pushReplacementNamed(context, SettingsView.routeName);
            }
          },
          builder: (context, state) {
            if(state is SignInLoading) {
              return Center(child: CircularProgressIndicator(),);
            }else{
              return SignInViewBody();
            }
          },
        ),
      ),
    );
  }
}
