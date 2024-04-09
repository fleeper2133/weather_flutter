import 'package:flutter/material.dart';
import 'package:weather_flutter/weather.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather App'),
      builder: EasyLoading.init()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late Weather weather;
  String dropDownValue = 'Moscow';
  var icon = Icons.sunny;

  @override
  void initState() {
    super.initState();
    _getWeather("Moscow");
  }

  

  void _getWeather(String city) async {
      await EasyLoading.show(status: 'loading...');
      weather = await fetchWeather(city);
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

      if (weather.preciptype.contains('rain')){
        icon = Icons.snowing;
      }else{
        icon = Icons.sunny;
      }
      await EasyLoading.dismiss();
  }

  void dropdownFunc(String? selectedValue) {

    if (selectedValue is String){
      
      setState(() {
        dropDownValue = selectedValue;
      });
      _getWeather(selectedValue);
      
      
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
    
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${weather.address}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Icon(icon),]),
            Text("${weather.description}",
            style: TextStyle(fontSize: 20)),
            Text("${weather.temp}°",
            style: Theme.of(context).textTheme.headlineMedium),
            DropdownButton(
              items: const [
              DropdownMenuItem(child: Text("Moscow"), value: "Moscow"),
              DropdownMenuItem(child: Text("London"), value: "London"),
              DropdownMenuItem(child: Text("Los Angeles"), value: "Los Angeles"),
              
              ],value: dropDownValue, onChanged: dropdownFunc, )
          ],
        ),
      ),
      
    );
  }
}



