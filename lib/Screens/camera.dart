import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dimofinf_camera_app/components/img_dialog.dart';
import 'package:dimofinf_camera_app/utils/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../service_locator.dart';
import 'package:flutter/services.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  final cameras = sL<List<CameraDescription>>();
  File image;

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _deleteCacheDir();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: new Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          new Positioned.fill(
            child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller)),
          ),
          Positioned(
            bottom: mediaQuery.size.height * 0.05,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: mediaQuery.size.height * 0.08,
                height: mediaQuery.size.height * 0.08,
                // margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      print('here');
                      Directory tempDir = await getTemporaryDirectory();
                      String tempPath = tempDir.path;
                      String cur = "$tempPath/${DateTime.now()}";
                      controller.takePicture(cur).then(
                            (value) => setState(
                              () {
                                image = File(cur);
                                showDialog(
                                        context: context,
                                        child: ImageDialog(image))
                                    .then(
                                  (value) {
                                    image = null;
                                  },
                                );
                              },
                            ),
                          );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: mediaQuery.size.width * 0.05,
            bottom: mediaQuery.size.height * 0.07,
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(PageRouteName.LOCAL_IMAGE),
              child: Container(
                height: mediaQuery.size.height * 0.04,
                width: mediaQuery.size.width * 0.2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
