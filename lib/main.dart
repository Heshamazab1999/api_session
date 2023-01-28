import 'dart:convert';

import 'package:api_session/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherModel? weatherModel;

  Future<WeatherModel?> getWeather() async {
    try {
      final response = await http.get(Uri.parse(
              "https://api.weatherapi.com/v1/current.json?key=8f3621bf17ff4a30b08132914232701&q=Alexandria&aqi=no")
          // Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=e456592dd8b81165c3908a6e796eb898")
          );
      print(response.body);
      if (response.statusCode == 200) {
        weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        return weatherModel;
      }

      print(response.body);
    } catch (e) {}
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: FutureBuilder<WeatherModel?>(
              future: getWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.location!.name!),
                      Text(snapshot.data!.location!.country!),
                      Text(snapshot.data!.location!.region!),
                      Text(snapshot.data!.location!.localtime!),
                      SizedBox(
                          height: 500,
                          width: 500,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(snapshot.data!.location!.lat!,
                                  snapshot.data!.location!.lon!),
                              zoom: 10,
                            ),
                            markers: Set<Marker>.of(markers.values),
                            onMapCreated: (controller) {
                              final marker = Marker(
                                  markerId: MarkerId("1"),
                                  position: LatLng(
                                      snapshot.data!.location!.lat!,
                                      snapshot.data!.location!.lon!));
                              setState(() {
                                markers[MarkerId('Alexandria')] = marker;
                              });
                            },
                          ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
