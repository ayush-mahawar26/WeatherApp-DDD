import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd/application/utils/show_snackbar.dart';
import 'package:weather_ddd/presentation/bloc/cubits/weather_cubit.dart';
import 'package:weather_ddd/presentation/bloc/states/weather_state.dart';

class CityWeatherView extends StatefulWidget {
  const CityWeatherView({super.key});

  @override
  State<CityWeatherView> createState() => _CityWeatherViewState();
}

class _CityWeatherViewState extends State<CityWeatherView> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                      hintText: "City",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1))),
                )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      String city = cityController.text.trim();
                      if (city.isNotEmpty) {
                        context.read<WeatherCubit>().fetchWeatherByCity(city);
                      } else {
                        ShowSnackBar(
                            context, "City Feild is empty", Colors.red);
                      }
                    },
                    child: const Text("Search"))
              ],
            ),
            Expanded(
                child: BlocConsumer<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherFetchErrorState) {
                        return Center(
                          child: Text(state.err),
                        );
                      }

                      if (state is WeatherFetchedState) {
                        return ListView(
                          children: state.weatherData.entries.map((entry) {
                            return ListTile(
                              title: Text(entry.key),
                              trailing: Text(entry.value.toString()),
                            );
                          }).toList(),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    listener: (context, state) {}))
          ],
        ),
      ),
    );
  }
}
