
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  DateTime lastLogin=DateTime.now();


  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int get residentId {
    return _prefs.getInt('residentId') ?? 0;
  }

  set residentId(int value) {
    _prefs.setInt('residentId', value);
  }

  int get expires_in {
    return _prefs.getInt('expires_in') ?? 0;
  }

  set expires_in(int value) {
    _prefs.setInt('expires_in', value);
  }

  String get userName {
    return _prefs.getString('userName') ?? '';
  }

  set userName(String value) {
    _prefs.setString('userName', value);
  }
  String get userEmail {
    return _prefs.getString('userEmail') ?? '';
  }

  set userEmail(String value) {
    _prefs.setString('userEmail', value);
  }
  String get userCodeUser {
    return _prefs.getString('userCodeUser') ?? '';
  }

  set userCodeUser(String value) {
    _prefs.setString('userCodeUser', value);
  }
  int get userCustomerId {
    return _prefs.getInt('userCustomerId') ?? 0;
  }

  set userCustomerId(int value) {
    _prefs.setInt('userCustomerId', value);
  }
  int get userId {
    return _prefs.getInt('userId') ?? 0;
  }

  set userId(int value) {
    _prefs.setInt('userId', value);
  }
  int get nabBarIndex {
    return _prefs.getInt('nabBarIndex') ?? 0;
  }

  set nabBarIndex(int value) {
    _prefs.setInt('nabBarIndex', value);
  }

  String get nombreEdificio {
    return _prefs.getString('nombreEdificio') ?? 'CORINSER';
  }

  set nombreEdificio(String value) {
    _prefs.setString('nombreEdificio', value);
  }
  
  String get access_token {
    return _prefs.getString('access_token') ?? 'EDIFICIO APP';
  }

  set access_token(String value) {
    _prefs.setString('access_token', value);
  }
  restaurarValoresPref(){
    expires_in=0;
    userName='';
    userEmail='';
    userCodeUser='';
    userCustomerId=0;
    userId=0;
    residentId=0;
    access_token='';
  }
}
