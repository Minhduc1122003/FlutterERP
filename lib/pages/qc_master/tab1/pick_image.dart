// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:erp/reusable/global_widget.dart';
import 'package:universal_io/io.dart' as IO;
import 'package:permission_handler/permission_handler.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  final Color _color1 = const Color(0xFF0181cc);
  final Color _color2 = const Color(0xff777777);

  File? _image;
  List<File> multipleImages = [];
  final _picker = ImagePicker();
  dynamic _selectedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void _askPermissionCamera() {
    requestPermission(Permission.camera).then(_onStatusRequestedCamera);
  }

  void _askPermissionStorage() {
    requestPermission(Permission.storage).then(_onStatusRequested);
  }

  void _askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);
  }

  void _onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage(ImageSource.gallery);
    }
  }

  void _onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage(ImageSource.camera);
    }
  }

  void _getImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      List<XFile>? picked = await _picker.pickMultiImage();
      setState(() {
        multipleImages.addAll(picked.map((e) => File(e.path)).toList());
      });
    } else {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          multipleImages.add(File(pickedImage.path));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CodeWithPatel"),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _askPermissionCamera();
                },
                child: const Text("Camera")),
            ElevatedButton(
                onPressed: () {
                  if (kIsWeb) {
                    _getImage(ImageSource.gallery);
                  } else {
                    if (IO.Platform.isIOS) {
                      _askPermissionPhotos();
                    } else {
                      _askPermissionStorage();
                    }
                  }
                },
                child: const Text("Gallery")),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 10),
                  itemCount: multipleImages.length,
                  itemBuilder: (context, index) {
                    return GridTile(child: Image.file(multipleImages[index]));
                  }),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buttonSave() {
  //   if (_selectedFile != null) {
  //     return Container(
  //       margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
  //       child: SizedBox(
  //         child: TextButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                     (Set<MaterialState> states) => _color1,
  //               ),
  //               overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               shape: MaterialStateProperty.all(
  //                   RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(3.0),
  //                   )
  //               ),
  //             ),
  //             onPressed: () {
  //               if (_selectedFile != null) {
  //                 if((!kIsWeb)){
  //                   // if run on android or ios, should check the file exist or not
  //                   if(_selectedFile!.existsSync()){
  //                     Fluttertoast.showToast(msg: 'Click save success', toastLength: Toast.LENGTH_SHORT);
  //                   }
  //                 } else {
  //                   Fluttertoast.showToast(msg: 'Click save success', toastLength: Toast.LENGTH_SHORT);
  //                 }
  //               } else {
  //                 Fluttertoast.showToast(
  //                     backgroundColor: Colors.red,
  //                     textColor: Colors.white,
  //                     msg: 'File not found',
  //                     fontSize: 13,
  //                     toastLength: Toast.LENGTH_SHORT);
  //               }
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //               child: Text(
  //                 'Save',
  //                 style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white),
  //                 textAlign: TextAlign.center,
  //               ),
  //             )
  //         ),
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
}
