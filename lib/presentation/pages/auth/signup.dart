import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd/application/constants/size_config.dart';
import 'package:weather_ddd/application/utils/show_snackbar.dart';
import 'package:weather_ddd/presentation/bloc/cubits/auth_cubit.dart';
import 'package:weather_ddd/presentation/bloc/states/auth_state.dart';
import 'package:weather_ddd/presentation/pages/auth/signin.dart';
import 'package:weather_ddd/presentation/pages/home/home_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: pass,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1))),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
                  if (state is AuthDoneState) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeView()),
                        (Route route) => false);
                  }

                  if (state is AuthErrorState) {
                    ShowSnackBar(context, state.err, Colors.red);
                  }
                }, builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return SizedBox(
                        width: SizeConfig.screenWidth * 0.5,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )));
                  }

                  return SizedBox(
                      width: SizeConfig.screenWidth * 0.5,
                      child: ElevatedButton(
                          onPressed: () {
                            String emailAddress = email.text.trim();
                            String password = pass.text.trim();
                            // we can also use Regex , but for now we just check if its empty or not
                            if (emailAddress.isNotEmpty &&
                                password.isNotEmpty) {
                              context
                                  .read<AuthCubit>()
                                  .signUpUser(emailAddress, password);
                            } else {
                              // show snackbar
                              ShowSnackBar(context, "feilds cant be empty !",
                                  Colors.red);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Sign Up'),
                          )));
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have Account ? ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninView()),
                            (Route route) => false)
                      },
                      child: Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
