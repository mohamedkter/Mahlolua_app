import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_cubit.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_states.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressCubit>(context).getAllAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    "عناوينك",
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/photo/logo.png"),
                        ),
                        color: MainColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 30,
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is SuccessAddressState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: BlocProvider.of<AddressCubit>(context)
                          .locations
                          .length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: MainColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 55,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: MainColor)),
                                                child: const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: MainColor,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      "${BlocProvider.of<AddressCubit>(context).locations[index]["specialMarque"]}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                          fontFamily: "Cairo",
                                                          fontSize: 19,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Container(
                                              width: 300,
                                              child: Text(
                                                "${BlocProvider.of<AddressCubit>(context).locations[index]["street"]}",
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                "${BlocProvider.of<AddressCubit>(context).locations[index]["city"]}"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                titleTextStyle: const TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                title: const Text(
                                                  'ازالة عنوان',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo'),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: const Text(
                                                    'هل انت متاكد من ازالة هذا العنوان',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo')),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('إلغاء',
                                                        style: TextStyle(
                                                            color: MainColor,
                                                            fontFamily:
                                                                'Cairo')),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('موافق',
                                                        style: TextStyle(
                                                            color: MainColor,
                                                            fontFamily:
                                                                'Cairo')),
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  AddressCubit>(
                                                              context)
                                                          .DeleteAddress(BlocProvider
                                                                      .of<AddressCubit>(
                                                                          context)
                                                                  .locations[
                                                              index]["id"]);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ))
                                ],
                              ),
                            ),
                          )),
                ],
              ),
            );
          } else if (state is LoadingAddressState) {
            return const GenerelLoadingPage();
          } else {
            return const NotFoundPage(
              Message: "لا يوجد عناوين حتي الان",
            );
          }
        },
      ),
    );
  }
}
