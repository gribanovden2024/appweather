import 'package:flutter/cupertino.dart';
import 'package:weather1/json_weatherapi_forecast/json_forecast.dart';

class HourlyForecastWidget extends StatelessWidget {
  final JsonForecast forecast;
  HourlyForecastWidget(this.forecast, {super.key});

  static DateTime now = DateTime.now();
  static int nowUnix = DateTime(now.year,now.month,now.day,now.hour).millisecondsSinceEpoch ~/ 1000;
  late int k;
  void _nowUnixInit() {
    for (int i=0;i<24;i++) {
      if (nowUnix==forecast.forecast.forecastday[0].hour[i].timeEpoch) {
        k=i;
        break;
      }
    }
  }
  Widget dayColumn(int i, String icon, int a) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('$iч'),
      Image.network('http:$icon',width: 32,height: 32,),
      Text('$a°'),
    ],
  );
  @override
  Widget build(BuildContext context) {
    _nowUnixInit();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i<6;i++,k++)
          if (k<24) dayColumn(
              k,
              forecast.forecast.forecastday[0].hour[k].condition.icon,
              forecast.forecast.forecastday[0].hour[k].tempC.ceil()
          )
          else dayColumn(
              k-24,
              forecast.forecast.forecastday[1].hour[k-24].condition.icon,
              forecast.forecast.forecastday[1].hour[k-24].tempC.ceil()
          )
      ],
    );
  }
}
