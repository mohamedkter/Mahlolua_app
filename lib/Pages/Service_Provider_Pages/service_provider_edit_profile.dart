import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/error_page.dart';
import 'package:mahloula/Pages/success_page.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

class EditServiceProviderProfile extends StatefulWidget {
  final int employeeId;
  EditServiceProviderProfile({Key? key, required this.employeeId}) : super(key: key);

  @override
  _EditServiceProviderProfileState createState() => _EditServiceProviderProfileState();
}

class _EditServiceProviderProfileState extends State<EditServiceProviderProfile> {
  bool isLoading = false;
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  File? personalImage;
  File? workImageOne;
  File? workImageTwo;
  File? workImageThree;
  File? workImageFour;

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

    bool profileUpdated = await PostMethods.updateEmployeeProfile(
      employeeId: widget.employeeId,
      name: nameController.text.isNotEmpty ? nameController.text : null,
      description: descController.text.isNotEmpty ? descController.text : null,
      minPrice: minPriceController.text.isNotEmpty ? int.parse(minPriceController.text) : null,
      image: personalImage,
    );

    if (profileUpdated) {
      bool workImagesUpdated = await PostMethods.updateWorkImages(
        employeeId: widget.employeeId,
        workImageOne: workImageOne,
        workImageTwo: workImageTwo,
        workImageThree: workImageThree,
        workImageFour: workImageFour,
      );

      if (workImagesUpdated) {
        _showSuccessPage();
      } else {
        _showErrorPage();
      }
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
          upperMessage: "هناك خطا ما حدث",
          lowerMessage: "يرجي اعادة المحاوله",
        ),
      ),
    );
  }

  void _showSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessPage(
          imageParh: 'assets/photo/doneAnamition.json',
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
                      TextFormField(
                        controller: descController,
                        decoration: InputDecoration(labelText: 'الوصف', border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: minPriceController,
                        decoration: InputDecoration(labelText: 'سعر المعاينة', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      PersonalImagePickerWidget(
                        image: personalImage,
                        imageTitle: "الصورة الشخصية",
                        getImageFunction: () => _pickImage((image) => personalImage = image),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 400, // Fixed height for the grid view
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                          ),
                          children: [
                            PastWorkImagePickerWidget(
                              getImageFunction: () => _pickImage((image) => workImageOne = image),
                              image: workImageOne,
                            ),
                            PastWorkImagePickerWidget(
                              getImageFunction: () => _pickImage((image) => workImageTwo = image),
                              image: workImageTwo,
                            ),
                            PastWorkImagePickerWidget(
                              getImageFunction: () => _pickImage((image) => workImageThree = image),
                              image: workImageThree,
                            ),
                            PastWorkImagePickerWidget(
                              getImageFunction: () => _pickImage((image) => workImageFour = image),
                              image: workImageFour,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor,
                          fixedSize: Size(MediaQuery.of(context).size.width / 1.1, 50),
                        ),
                        child: const Text(
                          "تاكيد",
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

class PastWorkImagePickerWidget extends StatelessWidget {
  final VoidCallback getImageFunction;
  final File? image;
  const PastWorkImagePickerWidget({
    Key? key,
    required this.getImageFunction,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getImageFunction,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 168,
          height: 112,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
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
    );
  }
}


