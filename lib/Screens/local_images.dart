import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class LocalImage extends StatefulWidget {
  @override
  _LocalImageState createState() => _LocalImageState();
}

class _LocalImageState extends State<LocalImage> {
  RequestType type = RequestType.image;

  var hasAll = true;

  var onlyAll = false;
  String minWidth = "0";
  String maxWidth = "10000";
  String minHeight = "0";
  String maxHeight = "10000";
  bool _ignoreSize = true;

  FilterOptionGroup makeOption() {
    SizeConstraint sizeConstraint;
    try {
      final minW = int.tryParse(minWidth);
      final maxW = int.tryParse(maxWidth);
      final minH = int.tryParse(minHeight);
      final maxH = int.tryParse(maxHeight);
      sizeConstraint = SizeConstraint(
        minWidth: minW,
        maxWidth: maxW,
        minHeight: minH,
        maxHeight: maxH,
        ignoreSize: _ignoreSize,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    any().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  File file;
  bool loading = true;
  List<File> files = [];
  List<AssetPathEntity> galleryList = [];
  int num = 10;
  int last = 10;
  int fileNum = 0;

  Future any() async {
    final option = makeOption();

    galleryList = await PhotoManager.getAssetPathList(
      type: type,
      hasAll: hasAll,
      onlyAll: onlyAll,
      filterOption: option,
    );
    print(galleryList.length);

    AssetPathEntity data = galleryList[fileNum];
    List<AssetEntity> imageList = await data.assetList;
    if (imageList.length > 0) {
      for (int i = 0; i < num; i++) {
        AssetEntity entity = imageList[i];
        file = await entity.file;
        files.add(file);
        print(files.length);
      }
    } else {
      fileNum++;
      AssetPathEntity data = galleryList[fileNum];
      List<AssetEntity> imageList = await data.assetList;
      for (int i = 0; i < num; i++) {
        AssetEntity entity = imageList[i];
        file = await entity.file;
        files.add(file);
        print(files.length);
      }
    }
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        num = num + 10;
        for (int i = last; i < num; i++) {
          AssetEntity entity = imageList[i];
          file = await entity.file;
          files.add(file);
          print(files.length);
        }
        last = num;
        setState(() {});
      }
    });
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !loading
          ? GridView.builder(
        
              controller: _scrollController,
              itemCount: files.length + 1,
              itemBuilder: (ctx, index) {
                if (index == files.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(files[index],
                      width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                );
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
