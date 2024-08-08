import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd/application/constants/size_config.dart';
import 'package:weather_ddd/application/utils/show_snackbar.dart';
import 'package:weather_ddd/presentation/bloc/cubits/auth_cubit.dart';
import 'package:weather_ddd/presentation/bloc/states/auth_state.dart';
import 'package:weather_ddd/presentation/pages/auth/signup.dart';
import 'package:weather_ddd/presentation/pages/home/home_view.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
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
                  "Sign In",
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
                                  .signInUser(emailAddress, password);
                            } else {
                              // show snackbar
                              ShowSnackBar(context, "feilds cant be empty !",
                                  Colors.red);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Sign In'),
                          )));
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account ? ",
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
                                builder: (context) => SignUpView()),
                            (Route route) => false)
                      },
                      child: Text(
                        "Sign up",
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
