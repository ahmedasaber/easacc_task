import 'package:easacc_task/features/auth/presentation/views/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../signin_cubit/signin_cubit.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSocialButton(onPressed: (){
            context.read<SignInCubit>().signInWithGoogle(context);
          }, title: 'signIn With Google', image: 'assets/icons/google-icon.svg'),
          const SizedBox(height: 16),
          CustomSocialButton(onPressed: (){
            context.read<SignInCubit>().signInWithFacebook(context);
          }, title: 'signIn With Facebook', image: 'assets/icons/facebook-icon.svg'),
          const SizedBox(height: 33),
        ],
      ),
    );
  }
}
