import 'package:bloc/bloc.dart';
import 'package:eyego_task/featchers/home/model/weather_model.dart';
import 'package:eyego_task/featchers/home/service/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  WeatherModel? weatherModel;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  void getWeather({required String cityName}) async {
    try {
      emit(WeatherLoding());
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherModel!));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
