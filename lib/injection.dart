import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_ddd/application/usecases/auth_usecase.dart';
import 'package:weather_ddd/application/usecases/weather_usecase.dart';
import 'package:weather_ddd/domain/repositories/auth_repo.dart';
import 'package:weather_ddd/domain/repositories/weather_repo.dart';
import 'package:weather_ddd/infrastructure/datasource/auth_datasource.dart';
import 'package:weather_ddd/infrastructure/datasource/weather_datasource.dart';
import 'package:weather_ddd/infrastructure/repositories_impl/auth_repo_impl.dart';
import 'package:weather_ddd/infrastructure/repositories_impl/weather_repo_impl.dart';
import 'package:weather_ddd/presentation/bloc/cubits/auth_cubit.dart';
import 'package:weather_ddd/presentation/bloc/cubits/weather_cubit.dart';

final s1 = GetIt.instance;

class Di {
  void init() {
    // Cubit
    s1.registerFactory(() => AuthCubit(authUseCase: s1()));
    s1.registerFactory(() => WeatherCubit(weatherUseCase: s1()));

    // Use Case
    s1.registerLazySingleton(() => AuthUseCase(authRepo: s1()));
    s1.registerLazySingleton(() => WeatherUseCase(weatherRepo: s1()));

    //Repo
    s1.registerLazySingleton<AuthRepository>(
        () => AuthRepoImplementation(authDataSource: s1()));
    s1.registerLazySingleton<WeatherRepo>(
        () => WeatherRepositoryImplementation(weatherDataSource: s1()));

    // DataSource
    s1.registerLazySingleton(() => AuthDataSource(auth: s1()));
    s1.registerLazySingleton(() => WeatherDataSource(dio: s1()));

    // Externa -> Dio
    s1.registerLazySingleton(() => FirebaseAuth.instance);
    s1.registerLazySingleton(() => Dio());
  }
}
