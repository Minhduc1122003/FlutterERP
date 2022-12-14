import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  List<File> multipleImages = [];

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
                onPressed: () async {
                  final XFile? pickedImage =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    setState(() {
                      multipleImages.add(File(pickedImage.path));
                    });
                  }
                },
                child: const Text("Camera")),
            ElevatedButton(
                onPressed: () async {
                  List<XFile>? picked = await _picker.pickMultiImage();
                  setState(() {
                    multipleImages.addAll(picked.map((e) => File(e.path)).toList());
                  });
                },
                child: const Text("Gallery")),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
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
}
