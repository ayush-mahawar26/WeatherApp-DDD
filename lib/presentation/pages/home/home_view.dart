import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_ddd/injection.dart';
import 'package:weather_ddd/presentation/bloc/cubits/auth_cubit.dart';
import 'package:weather_ddd/presentation/bloc/cubits/weather_cubit.dart';
import 'package:weather_ddd/presentation/bloc/states/weather_state.dart';
import 'package:weather_ddd/presentation/pages/home/city_weather.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getWeatherOfCurrentLocation() async {
    Position pos = await _determinePosition();
    context.read<WeatherCubit>().fetchWeatherByCity("delhi");
  }

  @override
  void initState() {
    getWeatherOfCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WeatherApp"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
                onTap: () {
                  context.read<AuthCubit>().signOut();
                },
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is WeatherFetchedState) {
                  Map<String, dynamic> data = state.weatherData;
                  return Expanded(
                    child: ListView(
                      children: data.entries.map((entry) {
                        return ListTile(
                          title: Text(entry.key),
                          trailing: Text(entry.value.toString()),
                        );
                      }).toList(),
                    ),
                  );
                }

                if (state is WeatherFetchErrorState) {
                  return Center(
                    child: Text(state.err),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CityWeatherView()));
                },
                child: const Text("Select City")),
          )
        ],
      ),
    );
  }
}
