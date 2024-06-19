import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Services/Api/post_methods.dart';

import '../../Models/employee_profile_model.dart';

// ignore: must_be_immutable
class ServiceProviderCredentials extends StatefulWidget {
  ServiceProviderCredentials({super.key});

  @override
  State<ServiceProviderCredentials> createState() =>
      _ServiceProviderCredentialsState();
}

class _ServiceProviderCredentialsState
    extends State<ServiceProviderCredentials> {
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController personalIdNumber = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController serviceproviderDecs = TextEditingController();
  File? personalImage;
  File? idImage;
  File? workImageOne;
  File? workImageTwo;
  File? workImageThree;
  File? workImageFour;
  String? serviceType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_forward_rounded,
                size: 30,
              ))
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "بيانات الاعتماد",
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 26, left: 26, right: 26),
          child: Column(
            children: [
//////////////////// pick personal images section ////////////////////

              PersonalImagePickerWidget(
                image: personalImage,
                imageTitle: "الصورة الشخصية",
                getImageFunction: () async {
                  XFile? pickedImage =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    pickedImage == null
                        ? null
                        : personalImage = File(pickedImage.path);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PersonalImagePickerWidget(
                image: idImage,
                imageTitle: "وجه البطاقة ",
                getImageFunction: () async {
                  XFile? pickedImage =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    pickedImage == null
                        ? null
                        : idImage = File(pickedImage.path);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),

              ///////////////////// pick personal information section   //////////////////////

              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                          textEditingController: personalIdNumber,
                          textFormFieldTitel: "الرقم القومي"),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          textEditingController: priceController,
                          textFormFieldTitel: "سعر المعاينة"),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        textEditingController: serviceproviderDecs,
                        textFormFieldTitel: "وصف الفنى وخبرتة",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "اختر نوع الخدمة",
                            style: TextStyle(
                                fontFamily: 'cairo',
                                color: MainColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 5,
                          child: DropdownButtonFormField<String>(
                            style: const TextStyle(fontSize: 20, color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            value: serviceType,
                            items: <String>[
                              'Option 1',
                              'Option 2',
                              'Option 3',
                              'Option 4',
                              'ho',
                              'Option 5',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                serviceType = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an option';
                              }
                              return null;
                            },
                          ),
                        ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),

              ////////////////// pick work image section /////////////////
           const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "صور اعمال سابقة",
              style: TextStyle(
                  fontFamily: 'cairo',
                  color: MainColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
              SizedBox(
                height: 400,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2),
                  children: [
                    PastWorkImagePickerWidget(
                        getImageFunction: () async {
                          XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            pickedImage == null
                                ? null
                                : workImageOne = File(pickedImage.path);
                          });
                        },
                        image: workImageOne),
                    PastWorkImagePickerWidget(
                        getImageFunction: () async {
                          XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            pickedImage == null
                                ? null
                                : workImageTwo = File(pickedImage.path);
                          });
                        },
                        image: workImageTwo),
                    PastWorkImagePickerWidget(
                        getImageFunction: () async {
                          XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            pickedImage == null
                                ? null
                                : workImageThree = File(pickedImage.path);
                          });
                        },
                        image: workImageThree),
                    PastWorkImagePickerWidget(
                        getImageFunction: () async {
                          XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            pickedImage == null
                                ? null
                                : workImageFour = File(pickedImage.path);
                          });
                        },
                        image: workImageFour),
                  ],
                ),
              ),


////////////////////// submit button section /////////////////

              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.validate();
                  EmployeeProfile obj = EmployeeProfile(
                      desc: serviceproviderDecs.text,
                      imageSSN: 'E:/Proooooooooject/pic.jpg',
                      imageLive: 'E:/Proooooooooject/pic.jpg',
                      SSN: int.parse(personalIdNumber.text),
                      minPrice: int.parse(priceController.text),
                      image1: 'E:/Proooooooooject/pic.jpg',
                      image2: 'E:/Proooooooooject/pic.jpg',
                      image3: 'E:/Proooooooooject/pic.jpg',
                      image4: 'E:/Proooooooooject/pic.jpg',
                      userId: 5,
                      serviceId: 1
                  );
                  PostMethods.createEmployee(obj);
                  print(serviceproviderDecs.text+"---"+personalIdNumber.text+"----");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.1, 50)),
                child:const Text("تاكيد",style: TextStyle(
                  fontFamily: 'cairo',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),),
              ),
        SizedBox(height: 40,)

            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.textEditingController,
      required this.textFormFieldTitel});
  final String textFormFieldTitel;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textFormFieldTitel,
              style: const TextStyle(
                  fontFamily: 'cairo',
                  color: MainColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 5,
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15))),
            controller: textEditingController,
          ),
        )
      ],
    );
  }
}

class PersonalImagePickerWidget extends StatelessWidget {
  final String imageTitle;
  final VoidCallback getImageFunction;
  final File? image;
  const PersonalImagePickerWidget({
    super.key,
    required this.imageTitle,
    required this.getImageFunction,
    required this.image,
  });

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
                  border: Border.all(color: Colors.grey)),
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
                          ))
                      : Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: FileImage(image!))),
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
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class PastWorkImagePickerWidget extends StatelessWidget {
  final VoidCallback getImageFunction;
  final File? image;
  const PastWorkImagePickerWidget({
    super.key,
    required this.getImageFunction,
    required this.image,
  });

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
              border: Border.all(color: Colors.grey)),
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
                      ))
                  : Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: FileImage(image!))),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
