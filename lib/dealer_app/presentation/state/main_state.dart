import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../pages/admin_panel_screen.dart';
import '../pages/home_screen.dart';
import '../pages/sale/sales_screen.dart';
import '../pages/settings_screen.dart';
import '../pages/vehicle/vehicle_register_screen.dart';

const appThemeKey = 'appThemeKey';
const appLanguageKey = 'appLanguageKey';

class MainState with ChangeNotifier {
  MainState() {
    init();
  }

  late final SharedPreferences _sharedPreferences;

  var _lightTheme = true;
  bool get lightTheme => _lightTheme;

  var _language = 'en';
  String get language => _language;

  Future<void> toggleLanguage({required String language}) async {
    _language = language;
    await _sharedPreferences.setString(appLanguageKey, _language);
    notifyListeners();
  }

  Future<void> toggleTheme({required bool value}) async {
    _lightTheme = value;
    await _sharedPreferences.setBool(appThemeKey, _lightTheme);
    notifyListeners();
  }

  void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _language = _sharedPreferences.getString(appLanguageKey) ?? 'en';
    _lightTheme = _sharedPreferences.getBool(appThemeKey) ?? true;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> widgetOptionsAdmin = <Widget>[
    const HomeScreen(),
    const VehicleRegisterScreen(),
    const AdminPanel(),
    const SalesScreen(),
    const SettingsScreen(),
  ];

  final List<Widget> widgetOptionsAssociate = <Widget>[
    const HomeScreen(),
    const VehicleRegisterScreen(),
    const SalesScreen(),
    const SettingsScreen(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  User? _loggedUser;
  User? get loggedUser => _loggedUser;

  void setLoggedUser(User? user) {
    _loggedUser = user;
    notifyListeners();
  }
}
