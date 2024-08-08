import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_ddd/application/utils/show_snackbar.dart';
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
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ShowSnackBar(context, "Location permissions are denied", Colors.red);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ShowSnackBar(
          context,
          "Location permissions are permanently denied, we cannot request permissions.",
          Colors.red);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getWeatherOfCurrentLocation() async {
    Position pos = await _determinePosition();
    context.read<WeatherCubit>().fetchWeatherUsingLatLong(pos);
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
