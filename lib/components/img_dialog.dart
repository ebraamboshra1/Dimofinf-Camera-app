import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageDialog extends StatefulWidget {
  final image;

  ImageDialog(this.image);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Center(
      child: Container(
        height: mediaQuery.size.height * 0.8,
        child: Stack(
          children: [
            Image.file(widget.image),
            Positioned(
              bottom: mediaQuery.size.height * 0.15,
              left: mediaQuery.size.width * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var tempDir = await getStorageDirectory();
                      final myImagePath = '${tempDir}/Dimofinf';
                      final myImgDir =
                          await new Directory(myImagePath).create();
                      File kompresimg =
                          new File("$myImagePath/${DateTime.now()}.jpg")
                            ..writeAsBytesSync(img.encodeJpg(
                                img.decodeImage(widget.image.readAsBytesSync()),
                                quality: 95));
                      print("File Path" + kompresimg.path);
                      var listOfFiles =
                          await myImgDir.list(recursive: true).toList();
                      var count = listOfFiles.length;
                      print(count);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: mediaQuery.size.height * 0.04,
                      width: mediaQuery.size.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 30,
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getBytesFromFile(widget.image).then((bytes) {
                        Share.file(
                            'Share via',
                            "${basename(widget.image.path)}.png",
                            bytes.buffer.asUint8List(),
                            'image/png');
                      });
                    },
                    child: Container(
                      height: mediaQuery.size.height * 0.04,
                      width: mediaQuery.size.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 30,
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: mediaQuery.size.height * 0.04,
                      width: mediaQuery.size.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile(image) async {
    Uint8List bytes = image.readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }

  Future<String> getStorageDirectory() async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory()).path;
    } else {
      return (await getApplicationDocumentsDirectory()).path;
    }
  }
}
