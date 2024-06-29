import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/General_Pages/error_page.dart';
import 'package:mahloula/Pages/General_Pages/success_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';

import 'package:mahloula/Services/Api/post_methods.dart';

class EditUserProfile extends StatefulWidget {
  final int userId;

  EditUserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  bool isLoading = false;
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  File? profileImage;

  Future<void> _pickImage(Function(File?) setImage) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        setImage(File(pickedFile.path));
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      isLoading = true;
    });

    bool profileUpdated = await PostMethods.updateUserProfile(
      userid: widget.userId,
      name: nameController.text.isNotEmpty ? nameController.text : null,
      image: profileImage,
    );

    setState(() {
      isLoading = false;
    });

    if (profileUpdated) {
      _showSuccessPage();
    } else {
      _showErrorPage();
    }
  }

  void _showErrorPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ErrorPage(
          imageParh: "assets/photo/loginError.json",
          upperMessage: "هناك خطأ ما حدث",
          lowerMessage: "يرجى إعادة المحاولة",
        ),
      ),
    );
  }

  void _showSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessPage(
          imageParh: 'assets/photo/doneAnimation.json',
          upperMessage: "تم تحديث البيانات بنجاح",
          lowerMessage: "جاري مراجعة بياناتك من قبل المختص",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تعديل بيانات",
          style: TextStyle(fontFamily: 'cairo', fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? GenerelLoadingPage()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'الاسم', border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 20),
                      PersonalImagePickerWidget(
                        image: profileImage,
                        imageTitle: "الصورة الشخصية",
                        getImageFunction: () => _pickImage((image) => profileImage = image),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor,
                          fixedSize: Size(MediaQuery.of(context).size.width / 1.1, 50),
                        ),
                        child: const Text(
                          "تأكيد",
                          style: TextStyle(
                            fontFamily: 'cairo',
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class PersonalImagePickerWidget extends StatelessWidget {
  final String imageTitle;
  final VoidCallback getImageFunction;
  final File? image;

  const PersonalImagePickerWidget({
    Key? key,
    required this.imageTitle,
    required this.getImageFunction,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: getImageFunction,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 168,
              height: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image == null
                      ? Container(
                          width: 110,
                          height: 110,
                          child: Image.asset(
                            "assets/photo/takePhoto.png",
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(image!)),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Text(
          imageTitle,
          style: const TextStyle(
            fontFamily: 'cairo',
            color: MainColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
