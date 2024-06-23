import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/validation.dart';
import 'package:mahloula/Models/service_model.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/error_page.dart';
import 'package:mahloula/Pages/success_page.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/Credentials_Cubit/credentials_cubit.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/Credentials_Cubit/credentials_status.dart';
import 'package:mahloula/Services/State_Managment/state.dart';

import '../../Functions/image_converter.dart';
import '../../Models/employee_profile_model.dart';

// ignore: must_be_immutable
class ServiceProviderCredentials extends StatefulWidget {
  int id;
  ServiceProviderCredentials({super.key, required this.id});

  @override
  State<ServiceProviderCredentials> createState() =>
      _ServiceProviderCredentialsState();
}

class _ServiceProviderCredentialsState
    extends State<ServiceProviderCredentials> {
  bool is_loading = false;
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
  int serviceId=1;
  String? serviceType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CredentialsCubit>(context).getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: is_loading == true
          ? GenerelLoadingPage()
          : SingleChildScrollView(
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
                                validatorFunction: (value) {
                                  return validateNationalId(value);
                                },
                                textEditingController: personalIdNumber,
                                textFormFieldTitel: "الرقم القومي"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormFieldWidget(
                                validatorFunction: (value) {
                                  return validatePrice(value);
                                },
                                textEditingController: priceController,
                                textFormFieldTitel: "سعر المعاينة"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormFieldWidget(
                              validatorFunction: (value) {
                                return validateDescription(value);
                              },
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
                            BlocBuilder<CredentialsCubit,CredentialsStatus>(
                              builder: (context, state) {
                                return Material(
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 5,
                                  child: DropdownButtonFormField<String>(
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    value: serviceType,
                                    items: state is SuccessStatus? BlocProvider.of<CredentialsCubit>(context).services.map<DropdownMenuItem<String>>(
                                        (Service value) {
                                      return DropdownMenuItem(
                                        value:value.name,
                                        child: Text(value.name),
                                      );
                                    }).toList():[],
                                    onChanged: (String? newValue) {
                                      Service service=BlocProvider.of<CredentialsCubit>(context).services.firstWhere((element) =>element.name==newValue,);
                                      serviceId=service.id;
                                      setState(() {
                                        serviceType = newValue;
                                      });
                                      print(serviceId);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'قم بختيار احد الخدمات';
                                      }
                                      return null;
                                    },
                                  ),
                                );
                              },
                            )
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            is_loading = true;
                          });
                          EmployeeProfile obj = EmployeeProfile(
                              desc: serviceproviderDecs.text,
                              SSN: personalIdNumber.text,
                              minPrice: int.parse(priceController.text),
                              userId: widget.id,
                              serviceId:serviceId);
                          FormData? livePhoto = personalImage == null
                              ? null
                              : await imageConverter(
                                  personalImage!, "livePhoto");

                          FormData? imageSSN = idImage == null
                              ? null
                              : await imageConverter(idImage!, "imageSSN");

                          FormData? work0 = workImageOne == null
                              ? null
                              : await imageConverter(
                                  workImageOne!, "works[0][image]");

                          FormData? work1 = workImageTwo == null
                              ? null
                              : await imageConverter(
                                  workImageTwo!, "works[1][image]");

                          FormData? work2 = workImageThree == null
                              ? null
                              : await imageConverter(
                                  workImageThree!, "works[2][image]");

                          FormData? work3 = workImageFour == null
                              ? null
                              : await imageConverter(
                                  workImageFour!, "works[3][image]");
                          bool response = await PostMethods.createEmployee(obj,
                              imageSSN, livePhoto, work0, work1, work2, work3);

                          if (response) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuccessPage(
                                  upperMessage: "تم التسجيل بنجاح",
                                  lowerMessage:
                                      "جاري مراجعة بياناتك من قبل المختص",
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ErrorPage(
                                  imageParh: "assets/photo/loginError.json",
                                  upperMessage: "هناك خطا ما حدث ",
                                  lowerMessage: "يرجي اعادة المحاوله",
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width / 1.1, 50)),
                      child: const Text(
                        "تاكيد",
                        style: TextStyle(
                            fontFamily: 'cairo',
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
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
      required this.validatorFunction,
      required this.textFormFieldTitel});
  final String textFormFieldTitel;
  final TextEditingController textEditingController;
  final String? Function(String?) validatorFunction;
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
            validator: validatorFunction,
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
