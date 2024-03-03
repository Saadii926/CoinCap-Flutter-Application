import 'dart:convert';
import 'package:coin_cap_app/models/app_config.dart';
import 'package:coin_cap_app/pages/home_page.dart';
import 'package:coin_cap_app/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPSerices();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString("assets/config/main.json");
  Map configData = jsonDecode(configContent);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(urlApiBaseUrl: configData["COIN_API_BASE_URL"]),
  );
}

void registerHTTPSerices() {
  GetIt.instance.registerSingleton<HTTPServies>(
    HTTPServies(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinCap_App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
      ),
      home: const HomePage(),
    );
  }
}
