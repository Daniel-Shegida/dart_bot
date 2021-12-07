import 'dart:io' show Platform;

// import 'dart:io' as io;

import 'package:dart_bot/data_service.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

void main() async {
  var telegram = Telegram("2105884501:AAETCBvFMO88Sp-59lB5cPLDu1lLLMQ1mB8");
  final _dataService = DataService();

  var event = Event((await telegram.getMe()).username!);

  final bot = TeleDart(telegram, event);

  Future<double> _search() async {
    final response = await _dataService.getWeather('Voronezh');
    // print("daad");
    // print(response.tempInfo.temperature);
    // setState(() => _response = response);
    return response.tempInfo.temperature;
  }

  bot.onCommand("start").listen((event) {
    // _search();
    event.reply("ok");
    var timerObservable = Stream.periodic(Duration(seconds: 1), (x) async{
        final response = await _dataService.getWeather('Voronezh');
      return response.tempInfo.temperature;
    }).listen((event2) {
    // event.reply(event2.toString());
    print("now");
      print(event2.then((value) {
            // event.reply(event2.toString());
        event.reply(value.toString());
        print(value);}));
    });
    ;
  });

  // bot.onMessage().listen((event) {
  //   print(event.location);

  //   print(event.location);
  //   print(event.from?.username);
  //   event.reply("${event.from?.id}");

  //   event.reply("ok");
  // });

  bot.start();
}
