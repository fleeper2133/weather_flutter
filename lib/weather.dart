import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
   final String address; 
   final String description;
   final String temp;
   final List<dynamic> preciptype;
   
   Weather(this.address, this.description, this.temp, this.preciptype); 
   factory Weather.fromMap(Map<String, dynamic> json) { 
    var temp = json['days'][0]["temp"];
    temp = (temp - 32) * 5/9;
    temp = temp.toStringAsFixed(2);
    var preciptype = json['days'][0]['preciptype'];
    if (preciptype == null){
      preciptype = [];
    }
      return Weather( 
         json['address'], 
         json['days'][0]['description'], 
         temp,
         preciptype
      );
   }
  
}

Weather parseWeather(String responseBody) { 
   final parsed = jsonDecode(responseBody); 
   return Weather.fromMap(parsed); 
} 
Future<Weather> fetchWeather(String city) async { 
   final response = await http.get(Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${city}?key=CW79YFE2KYUELJMSAVFWFRZT6')); 
   if (response.statusCode == 200) { 
      return parseWeather(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}