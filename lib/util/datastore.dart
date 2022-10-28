import 'package:shared_preferences/shared_preferences.dart';

class Datastore {
  Future<bool> setShowDelay(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('showdelay', value);
  }

  Future<bool> getShowDelay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showdelay') ?? true;
  }

  Future<bool> setDuration(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('duration', value);
  }

  Future<int> getDuration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('duration') ?? 5;
  }

  Future<bool> setOffset(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('offset', value);
  }

  Future<double> getOffset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('offset') ?? 70;
  }

  Future<bool> setIP(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('ip', value);
  }

  Future<String> getIP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('ip') ?? '192.168.1.1';
  }
}
