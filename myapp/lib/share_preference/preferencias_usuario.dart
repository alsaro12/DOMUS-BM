
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;

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
  String get number_document {
    return _prefs.getString('number_document') ?? '';
  }

  set number_document(String value) {
    _prefs.setString('number_document', value);
  }
  String get phone {
    return _prefs.getString('phone') ?? '';
  }

  set phone(String value) {
    _prefs.setString('phone', value);
  }
  String get date_birth {
    return _prefs.getString('date_birth') ?? '';
  }

  set date_birth(String value) {
    _prefs.setString('date_birth', value);
  }
  String get commentary {
    return _prefs.getString('commentary') ?? '';
  }

  set commentary(String value) {
    _prefs.setString('commentary', value);
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
    commentary='';
    date_birth='';
    phone='';
    number_document='';

  }
  Future updatePerfil() async {
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show(status: 'Actualizando informacion');
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/update_profile');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${pref.access_token}',
        },
        body: {
          'number_document': pref.number_document,
          'phone': pref.phone,
          'date_birth': pref.date_birth,
          // 'date_birth': '',
          'commentary': pref.commentary,
        }
      );
      print(pref.date_birth);
        print(response.body);
        
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'Ocurrior un error a la hora de actualizar su perfil.\n Cierre y vuelva a abrir la app.');
    }
  }
}
