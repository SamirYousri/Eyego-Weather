// ignore_for_file: must_be_immutable

import 'package:eyego_task/core/utils/constant.dart';
import 'package:eyego_task/featchers/home/manager/weather_cubit/weather_cubit.dart';
import 'package:eyego_task/featchers/home/views/weather_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key});
  String? cityName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Search a City',
          style: TextStyle(fontSize: screenWidth * 0.06),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter City Name',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                onChanged: (data) {
                  cityName = data.trim();
                },
                onSubmitted: (data) {
                  _searchWeather(context);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.05),
                  labelText: 'Search',
                  hintText: 'Enter a city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      _searchWeather(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Icon(
                        Icons.search,
                        size: screenWidth * 0.07,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchWeather(BuildContext context) {
    if (cityName != null && cityName!.isNotEmpty) {
      context.read<WeatherCubit>().getWeather(cityName: cityName!);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return WeatherDetailsView();
        },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid city name!')),
      );
    }
  }
}
