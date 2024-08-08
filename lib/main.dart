import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd/application/constants/size_config.dart';
import 'package:weather_ddd/firebase_options.dart';
import 'package:weather_ddd/injection.dart';
import 'package:weather_ddd/presentation/bloc/cubits/auth_cubit.dart';
import 'package:weather_ddd/presentation/bloc/cubits/weather_cubit.dart';
import 'package:weather_ddd/presentation/pages/auth/signup.dart';
import 'package:weather_ddd/presentation/pages/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Di().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => s1<AuthCubit>()),
        BlocProvider(create: (context) => s1<WeatherCubit>()),
      ],
      child: MaterialApp(
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeView();
              }
              return SignUpView();
            }),
      ),
    );
  }
}
