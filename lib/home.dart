import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _capturedImage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Iqbal ganteng'),
          ),
          body: Builder(builder: (context) {
            if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 8, 184, 242),
                          foregroundColor: Colors.white,
                          onPressed: () =>
                              setState(() => _capturedImage = null),
                          child: Icon(Icons.close),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 8, 184, 242),
                          foregroundColor: Colors.white,
                          onPressed: () {},
                          child: Icon(Icons.check),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            return SmartFaceCamera(
                autoCapture: true,
                defaultCameraLens: CameraLens.front,
                onCapture: (File? image) {
                  setState(() => _capturedImage = image);
                },
                onFaceDetected: (Face? face) {
                  //Do something
                },
                messageBuilder: (context, face) {
                  if (face == null) {
                    return _message('Posisikan wajah anda dalam kamera');
                  }
                  if (!face.wellPositioned) {
                    return _message('Posisikan wajah anda dalam bingkai');
                  }
                  return const SizedBox.shrink();
                });
          })),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
