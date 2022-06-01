import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/main.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  TextEditingController comentario = TextEditingController();
  CameraController? controller;
  XFile? imageFile;

  void _showCameraException(CameraException e) {
    EasyLoading.showInfo('Error: ${e.code}\n${e.description}');
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      EasyLoading.showInfo('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {

      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> onTakePictureButtonPressed(context) async {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
        }
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: ThisColors.primary.withOpacity(0.7),
            children: [
              Container(
                width: 350,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_add_check_circle_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Imagen seleccionada',
                          style: ThisColors.titulo(
                              ThisColors.white, 16, FontWeight.bold),
                        ),
                      ],
                    ),
                    Gap(10),
                    Container(
                      width: 150,
                      height: 250,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Gap(20),
                    ListTile(
                      leading: Text(
                        'Comentario',
                        style: TextStyle(color: Colors.white),
                      ),
                      title: TextFormField(
                        controller: comentario,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: ('Comentario aquí'),
                          hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                border: Border.all(
                                    width: 3.0, color: ThisColors.primary),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Volver a tomar foto',
                                  style: ThisColors.titulo(
                                      ThisColors.white, 14, FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Gap(15),
                          GestureDetector(
                            onTap: () async {
                              var deudaP = Provider.of<DeudaProvider>(context,
                                  listen: false);
                              var usuarioP = Provider.of<UsuarioProvider>(
                                  context,
                                  listen: false);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              EasyLoading.show(status: 'Subiendo foto');
                              if (file != null) {
                                await deudaP.pagarDeduda(
                                  context,
                                  usuarioP.propiedadSelected.r_block_id,
                                  comentario.text,
                                  file,
                                  [],
                                );
                                await EasyLoading.showSuccess(
                                    'Foto cargada con exito');
                              } else {
                                EasyLoading.showInfo('Error de conexión');
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: ThisColors.turquesa,
                                // border: Border.all(
                                //     width: 4.0,
                                //     color: Color.fromARGB(255, 53, 30, 90)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Usar foto',
                                  style: ThisColors.titulo(
                                      ThisColors.white, 14, FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: ThisColors.primary,
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: 'CAMARA',
        bgColor: ThisColors.turquesa,
        backButton: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(controller!),
          ),
          // Expanded(
          //   child: CameraPreview(controller!),
          // ),
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width - 50) / 2,
            child: GestureDetector(
              onTap: () {
                onTakePictureButtonPressed(context);
              },
              child: Container(
                width: 75,
                height: 75,
                child: Icon(
                  Icons.camera,
                  color: ThisColors.white,
                  size: 75,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
