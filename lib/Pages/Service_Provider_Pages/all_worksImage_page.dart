import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_credentials_page.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/State_Managment/state.dart';

import '../../Functions/image_converter.dart';
import '../../Services/Data/cache_data.dart';

class WorkImages extends StatefulWidget {
  const WorkImages({Key? key}) : super(key: key);

  @override
  State<WorkImages> createState() => _WorkImagesState();
}

class _WorkImagesState extends State<WorkImages> {
  ImagePicker picker = ImagePicker();
  File? workImageOne;
  Map m1 = {};
  Map m2 = {};
  Map m3 = {};
  Map m4 = {};
  //Id? obj;
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    //obj?.id = CacheData.getData(key: "userId");
    m1 = await GetMethods().getWorkImages(CacheData.getData(key: "userId"), 0);
    m2 = await GetMethods().getWorkImages(CacheData.getData(key: "userId"), 1);
    m3 = await GetMethods().getWorkImages(CacheData.getData(key: "userId"), 2);
    m4 = await GetMethods().getWorkImages(CacheData.getData(key: "userId"), 3);
    setState(() {});
  }

  int x = CacheData.getData(key: 'userId');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الاعمال السابقه',
          style:
              TextStyle(fontFamily: 'cairo', fontSize: 24.0, color: MainColor),
        ),
      ),
      body: Center(
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15, mainAxisSpacing: 15, crossAxisCount: 2),
          children: [
            PastWorkImagePickerWidget2(
                updateImageFunction: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      workImageOne = File(pickedFile.path);
                    });
                  } else {
                    print('No image selected.');
                  }
                  PostMethods().updateWorkImage(x,workImageOne,'works[0][image]');
                },
                image: m1['image_url']),
            PastWorkImagePickerWidget2(
                updateImageFunction: () async
                {
                  final picker = ImagePicker();
                  final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      workImageOne = File(pickedFile.path);
                    });
                  } else {
                    print('No image selected.');
                  }
                  PostMethods().updateWorkImage(x,workImageOne,'works[1][image]');
                }, image: m2['image_url']),
            PastWorkImagePickerWidget2(
                updateImageFunction: () async
                {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      workImageOne = File(pickedFile.path);
                    });
                  } else {
                    print('No image selected.');
                  }
                  PostMethods().updateWorkImage(x,workImageOne,'works[2][image]');
                }, image: m3['image_url']),
            PastWorkImagePickerWidget2(
                updateImageFunction: () async
                {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      workImageOne = File(pickedFile.path);
                    });
                  } else {
                    print('No image selected.');
                  }
                  PostMethods().updateWorkImage(x,workImageOne,'works[3][image]');
                }, image: m4['image_url']),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        workImageOne = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }
}

class Id {
  int id;
  Id(this.id);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}

class PastWorkImagePickerWidget2 extends StatelessWidget {
  final VoidCallback updateImageFunction;
  final String? image;
  const PastWorkImagePickerWidget2({
    super.key,
    required this.updateImageFunction,
    this.image,
  });

  final String partImag = 'https://mahllola.online/public';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {},
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                width: 168,
                height: 212,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image != null
                        ? Container(
                            width: 110,
                            height: 110,
                            child: Image.network(partImag + image!),
                          )
                        : CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: updateImageFunction,
              icon: Icon(
                Icons.edit,
                color: MainColor,
              )),
        ],
      ),
    );
  }
}
