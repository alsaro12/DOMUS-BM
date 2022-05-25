import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'dart:io' as Io;

import 'package:myapp/share_preference/route_transition_do.dart';

class BlogProvider with ChangeNotifier {
  List<Blog> _listPublicaciones = [];

  List<Blog> get listPublicaciones => _listPublicaciones;

  set listPublicaciones(List<Blog> listPublicaciones) {
    _listPublicaciones = listPublicaciones;
  }

  Future<List<Blog>> cargarPublicaciones() async {
    listPublicaciones = [];
    try {
      var pref = PreferenciasUsuario();
      // EasyLoading.show();
      var url = Uri.parse('https://app.domusbm.com/api/resident/publications');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Blog notificaciones = Blog();
        notificaciones.fromJson(item as Map<String, dynamic>);
        listPublicaciones.add(notificaciones);
      }
      return listPublicaciones;
    } catch (e) {
      EasyLoading.showError('Error de conexion al servidor 2 $e');
      return listPublicaciones;
    }
  }
}

class Blog {
  String name_building = '';
  String head_publication = '';
  String body_publication = '';
  String publication_date = '';
  String url_image_publication = '';
  fromJson(Map<String, dynamic> map) {
    if (map['name_building'] != null) {
      name_building = map['name_building'];
    }
    if (map['head_publication'] != null) {
      head_publication = map['head_publication'];
    }
    if (map['body_publication'] != null) {
      body_publication = map['body_publication'];
    }
    if (map['url_image_publication'] != null) {
      url_image_publication = map['url_image_publication'];
    }
    if (map['publication_date'] != null) {
      publication_date = map['publication_date'];
    }
  }
}

class DeudaProvider with ChangeNotifier {
  Future pagarDeduda(context, int rBlockId, String comentario, XFile file,
      List<int> listReciepId) async {
    // List<Propiedad> listP = [];
    try {
      var pref = PreferenciasUsuario();
      final bytes = await Io.File(file.path).readAsBytes();
      EasyLoading.show(status: 'Subiendo foto');
      var url =
          Uri.parse('https://app.domusbm.com/api/resident/upload_voucher');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      }, body: {
        "r_block_id": rBlockId.toString(),
        "commentary": comentario,
        "image_voucher": bytes.toString(),
      });
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'Verifique sus credenciales, no cuenta con este permiso');
    }
  }
}

class Deuda {
  String name_period_receipt = '';
  String amount_debt = '';
  String url_receipt = '';

  fromJson(Map<String, dynamic> map) async {
    if (map['name_period_receipt'] != null) {
      name_period_receipt = map['name_period_receipt'];
    }
    if (map['amount_debt'] != null) {
      amount_debt = map['amount_debt'];
    }
    if (map['url_receipt'] != null) {
      url_receipt = map['url_receipt'];
    }
  }
}

class InformacionPropiedad {
  String? nameRealestate;
  String? totalArea;
  String? totalHolding;
  String? totalPositiveBalance;
  List<Residents>? residents;
  List<Estates>? estates;
  List<Parkings>? parkings;
  List<Warehouses>? warehouses;

  InformacionPropiedad(
      {this.nameRealestate,
      this.totalArea,
      this.totalHolding,
      this.totalPositiveBalance,
      this.residents,
      this.estates,
      this.parkings,
      this.warehouses});

  InformacionPropiedad.fromJson(Map<String, dynamic> json) {
    nameRealestate = json['name_realestate'];
    totalArea = json['total_area'];
    totalHolding = json['total_holding'];
    totalPositiveBalance = json['total_positive_balance'];
    if (json['residents'] != null) {
      residents = <Residents>[];
      json['residents'].forEach((v) {
        residents!.add(new Residents.fromJson(v));
      });
    }
    if (json['estates'] != null) {
      estates = <Estates>[];
      json['estates'].forEach((v) {
        estates!.add(new Estates.fromJson(v));
      });
    }
    if (json['parkings'] != null) {
      parkings = <Parkings>[];
      json['parkings'].forEach((v) {
        parkings!.add(new Parkings.fromJson(v));
      });
    }
    if (json['warehouses'] != null) {
      warehouses = <Warehouses>[];
      json['warehouses'].forEach((v) {
        warehouses!.add(new Warehouses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_realestate'] = this.nameRealestate;
    data['total_area'] = this.totalArea;
    data['total_holding'] = this.totalHolding;
    data['total_positive_balance'] = this.totalPositiveBalance;
    if (this.residents != null) {
      data['residents'] = this.residents!.map((v) => v.toJson()).toList();
    }
    if (this.estates != null) {
      data['estates'] = this.estates!.map((v) => v.toJson()).toList();
    }
    if (this.parkings != null) {
      data['parkings'] = this.parkings!.map((v) => v.toJson()).toList();
    }
    if (this.warehouses != null) {
      data['warehouses'] = this.warehouses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Residents {
  String? fullname;
  String? nameAtributes;

  Residents({this.fullname, this.nameAtributes});

  Residents.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    nameAtributes = json['name_atributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['name_atributes'] = this.nameAtributes;
    return data;
  }
}

class Estates {
  String? numberSection;
  String? area;
  String? holding;

  Estates({this.numberSection, this.area, this.holding});

  Estates.fromJson(Map<String, dynamic> json) {
    numberSection = json['number_section'];
    area = json['area'];
    holding = json['holding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_section'] = this.numberSection;
    data['area'] = this.area;
    data['holding'] = this.holding;
    return data;
  }
}

class Parkings {
  String? numberSection;
  String? area;
  String? holding;

  Parkings({this.numberSection, this.area, this.holding});

  Parkings.fromJson(Map<String, dynamic> json) {
    numberSection = json['number_section'];
    area = json['area'];
    holding = json['holding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_section'] = this.numberSection;
    data['area'] = this.area;
    data['holding'] = this.holding;
    return data;
  }
}

class Warehouses {
  String? numberSection;
  String? area;
  String? holding;

  Warehouses({this.numberSection, this.area, this.holding});

  Warehouses.fromJson(Map<String, dynamic> json) {
    numberSection = json['number_section'];
    area = json['area'];
    holding = json['holding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_section'] = this.numberSection;
    data['area'] = this.area;
    data['holding'] = this.holding;
    return data;
  }
}

class NavBarProvider with ChangeNotifier {
  double _index = 2;

  double get index => _index;

  set index(double index) {
    _index = index;
    notifyListeners();
  }
}

class NabBar {}

class NotificacionesProvider with ChangeNotifier {
  int _cantNotSinLeer = 0;

  int get cantNotSinLeer => _cantNotSinLeer;

  set cantNotSinLeer(int cantNotSinLeer) {
    _cantNotSinLeer = cantNotSinLeer;
    notifyListeners();
  }

  List<Notificaciones> listNotificaciones = [];

  verificarNotificacionesSinLeer() {
    cantNotSinLeer = 0;
    for (var i = 0; i < listNotificaciones.length; i++) {
      Notificaciones notificaciones = Notificaciones();
      notificaciones = listNotificaciones.elementAt(i);
      if (notificaciones.condition!.compareTo('0') == 0) {
        cantNotSinLeer++;
      }
    }
  }

  Future<List<Notificaciones>> cargarNotificaciones() async {
    listNotificaciones = [];
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      // var url = Uri.parse(
      //     'https://app.domusbm.com/api/resident/notifications/${pref.residentId}');
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/notifications');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Notificaciones notificaciones = Notificaciones();
        notificaciones.fromJson(item as Map<String, dynamic>);
        listNotificaciones.add(notificaciones);
      }
      verificarNotificacionesSinLeer();
      EasyLoading.dismiss();
      return listNotificaciones;
    } catch (e) {
      EasyLoading.showError('Error de conexion al servidor 2 $e');
      return listNotificaciones;
    }
  }
}

class Notificaciones {
  int? notification_to_user_id;
  String? title;
  String? body;
  String? date_created;
  String? condition;
  fromJson(Map<String, dynamic> map) {
    if (map['notification_to_user_id'] != null) {
      notification_to_user_id = map['notification_to_user_id'];
    }
    if (map['title'] != null) {
      title = map['title'];
    }
    if (map['body'] != null) {
      body = map['body'];
    }
    if (map['date_created'] != null) {
      date_created = map['date_created'];
    }
    if (map['condition'] != null) {
      condition = map['condition'];
    }
  }

  Future marcaLeida() async {
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show(status: 'Cargando data');
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/update_notification/${notification_to_user_id}');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${pref.access_token}',
        },
      );
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'Verifique sus credenciales, no cuenta con este permiso');
    }
  }
}

class PagosProvider with ChangeNotifier {}

class Pago {
  int? collection_id;
  String total_amount_collection = '';
  String collection_date = '';
  int is_positive_balance = 0;
  String amount_positive_balance = '';
  fromJson(Map<String, dynamic> map) {
    if (map['collection_id'] != null) {
      collection_id = map['collection_id'];
    }
    if (map['total_amount_collection'] != null) {
      total_amount_collection = map['total_amount_collection'];
    }
    if (map['collection_date'] != null) {
      collection_date = map['collection_date'];
    }
    if (map['is_positive_balance'] != null) {
      is_positive_balance = map['is_positive_balance'];
    }
    if (map['amount_positive_balance'] != null) {
      amount_positive_balance = map['amount_positive_balance'];
    }
  }
}

class Propiedad {
  int r_block_id = 0;
  String name_realestate = '';
  int building_id = 0;
  String name_building = '';
  String image_building = '';
  String amount_debt = '';
  List<Deuda> listaDeudas = [];
  InformacionPropiedad informacionPropiedad = InformacionPropiedad();
  toJson() {
    return {
      'r_block_id': r_block_id,
      'name_realestate': name_realestate,
      'building_id': building_id,
      'name_building': name_building,
      'image_building': image_building,
    };
  }

  fromJson(Map<String, dynamic> map) {
    if (map['r_block_id'] != null) {
      r_block_id = map['r_block_id'];
    }
    if (map['name_realestate'] != null) {
      name_realestate = map['name_realestate'];
    }
    if (map['building_id'] != null) {
      building_id = map['building_id'];
    }
    if (map['name_building'] != null) {
      name_building = map['name_building'];
    }
    if (map['image_building'] != null) {
      image_building = map['image_building'];
    }
  }

  CargarAmountDebt(int r_block_id) async {
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/select_block/${r_block_id}');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        amount_debt = item['amount_debt'];
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError('Error de conexion al servidor');
    }
  }

  cargarDeudas(int r_block_id) async {
    listaDeudas = [];
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/list_debt/${r_block_id}');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Deuda deuda = Deuda();
        deuda.fromJson(item as Map<String, dynamic>);
        listaDeudas.add(deuda);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError('Error de conexion al servidor 2 $e');
    }
  }

  Future<InformacionPropiedad> cargarInformacion(int r_block_id) async {
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url =
          Uri.parse('https://app.domusbm.com/api/resident/info/${r_block_id}');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      InformacionPropiedad informacionPropiedad =
          InformacionPropiedad.fromJson(userMap);
      EasyLoading.dismiss();
      return informacionPropiedad;
    } catch (e) {
      InformacionPropiedad informacionPropiedad = InformacionPropiedad(
          estates: [],
          nameRealestate: '',
          parkings: [],
          residents: [],
          totalArea: '',
          totalHolding: '',
          totalPositiveBalance: '',
          warehouses: []);
      EasyLoading.showError('Error de conexion al servidor 2 $e');
      return informacionPropiedad;
    }
  }
}

class RecibosProvider with ChangeNotifier {}

class Recibos {
  int? receipt_id;
  String name_period_receipt = '';
  String total_receipt = '';
  String condition = '';
  String url_receipt = '';
  fromJson(Map<String, dynamic> map) {
    if (map['receipt_id'] != null) {
      receipt_id = map['receipt_id'];
    }
    if (map['name_period_receipt'] != null) {
      name_period_receipt = map['name_period_receipt'];
    }
    if (map['total_receipt'] != null) {
      total_receipt = map['total_receipt'];
    }
    if (map['condition'] != null) {
      condition = map['condition'];
    }
    if (map['url_receipt'] != null) {
      url_receipt = map['url_receipt'];
    }
  }
}

class User {
  int? id;
  int? customerId;
  int? roleId;
  int? icode;
  String? codeUser;
  String? name;
  String? email;
  String? emailVerifiedAt;

  int? residentId;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;
  List<Propiedad> listPropiedades = [];
  List<Pago> listaPagos = [];
  List<Recibos> listRecibos = [];
  String date_birth='';
  String phone='';
  String number_document='';
  String commentary='';

  Future cargarPropiedades(context) async {
    List<Propiedad> listP = [];
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url =
          Uri.parse('https://app.domusbm.com/api/resident/realestateblocks');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Propiedad propiedad = Propiedad();
        propiedad.fromJson(item as Map<String, dynamic>);
        listP.add(propiedad);
      }
      listPropiedades = listP;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'Verifique sus credenciales, no cuenta con este permiso');
      RouteTransitionDo(
        context: context,
        animationType: AnimationType.fadeIn,
        child: LoginPage(),
      );
    }
  }

  Future cargarRecibos(int r_block_id) async {
    List<Recibos> listR = [];
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/list_receipt/$r_block_id');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Recibos recibo = Recibos();
        recibo.fromJson(item as Map<String, dynamic>);
        listR.add(recibo);
      }
      listRecibos = listR;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'The server successfully processed the request, but is not returning any content.');
    }
  }

  Future cargarPagos(int r_block_id) async {
    List<Pago> listP = [];
    try {
      var pref = PreferenciasUsuario();
      EasyLoading.show();
      var url = Uri.parse(
          'https://app.domusbm.com/api/resident/list_payment/${r_block_id}');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${pref.access_token}',
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      for (var item in userMap) {
        Pago pago = Pago();
        pago.fromJson(item as Map<String, dynamic>);
        listP.add(pago);
      }
      listaPagos = listP;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(
          'The server successfully processed the request, but is not returning any content.');
    }
  }

  User(
      {this.id,
      this.customerId,
      this.roleId,
      this.icode,
      this.codeUser,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.residentId,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.isDeleted
      });

  fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['customer_id'] != null) {
      customerId = json['customer_id'];
    }
    if (json['role_id'] != null) {
      roleId = json['role_id'];
    }
    if (json['icode'] != null) {
      icode = json['icode'];
    }
    if (json['code_user'] != null) {
      codeUser = json['code_user'];
    }
    if (json['name'] != null) {
      name = json['name'];
    }
    if (json['email'] != null) {
      email = json['email'];
    }
    if (json['email'] != null) {
      email = json['email'];
    }
    if (json['email_verified_at'] != null) {
      emailVerifiedAt = json['email_verified_at'];
    }
    if (json['resident_id'] != null) {
      residentId = json['resident_id'];
    }
    if (json['is_active'] != null) {
      isActive = json['is_active'];
    }
    if (json['created_at'] != null) {
      createdAt = json['created_at'];
    }
    if (json['updated_at'] != null) {
      updatedAt = json['updated_at'];
    }
    if (json['is_deleted'] != null) {
      isDeleted = json['is_deleted'];
    }
    if (json['number_document'] != null) {
      number_document = json['number_document'];
    }
    if (json['date_birth'] != null) {
      date_birth = json['date_birth'];
    }
    if (json['phone'] != null) {
      phone = json['phone'];
    }
    if (json['commentary'] != null) {
      commentary = json['commentary'];
    }
    // customerId = json['customer_id'];
    // roleId = json['role_id'];
    // icode = json['icode'];
    // codeUser = json['code_user'];
    // name = json['name'];
    // email = json['email'];
    // emailVerifiedAt = json['email_verified_at'];
    // residentId = json['resident_id'];
    // isActive = json['is_active'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['role_id'] = this.roleId;
    data['icode'] = this.icode;
    data['code_user'] = this.codeUser;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['resident_id'] = this.residentId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}

class UsuarioProvider with ChangeNotifier {
  Propiedad _propiedadSelected = Propiedad();

  Propiedad get propiedadSelected => _propiedadSelected;

  set propiedadSelected(Propiedad propiedadSelected) {
    _propiedadSelected = propiedadSelected;
    notifyListeners();
  }

  User _usuarioSelected = User();

  User get usuarioSelected => _usuarioSelected;

  set usuarioSelected(User usuarioSelected) {
    _usuarioSelected = usuarioSelected;
    notifyListeners();
  }
}
