import 'package:eyego_task/core/utils/constant.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/featchers/home/manager/weather_cubit/weather_cubit.dart';
import 'package:eyego_task/featchers/home/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailsViewBody extends StatelessWidget {
  const WeatherDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchView();
              }));
            },
            icon: Icon(Icons.search, size: screenWidth * 0.07),
          ),
        ],
        title: Text(
          'Eyego Weather',
          style: TextStyle(fontSize: screenWidth * 0.06),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoding) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherFailure) {
            return Center(
              child: Text(
                'Failed to fetch weather data 😔',
                style: TextStyle(fontSize: screenWidth * 0.06),
              ),
            );
          } else if (state is WeatherSuccess) {
            final weatherData = context.read<WeatherCubit>().weatherModel;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    weatherData!.location,
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Updated at : ${weatherData.date.hour}:${weatherData.date.minute}',
                    style: Styles.textStyle22,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        weatherData.weatherIcon,
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                      ),
                      Text(
                        '${weatherData.temp.toInt()}°C',
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Max: ${weatherData.maxTemp.toInt()}°C',
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Text(
                            'Min: ${weatherData.minTemp.toInt()}°C',
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    weatherData.weatherStateName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'There is no weather 😔',
                    style: TextStyle(fontSize: screenWidth * 0.06),
                  ),
                  Text(
                    'Start searching now 🔍',
                    style: TextStyle(fontSize: screenWidth * 0.06),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
