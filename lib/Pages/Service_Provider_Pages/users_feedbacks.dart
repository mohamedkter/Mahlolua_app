import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/date_converter.dart';
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_cubit.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_states.dart';

class UsersFeedbacks extends StatefulWidget {
  const UsersFeedbacks({super.key});

  @override
  State<UsersFeedbacks> createState() => _UsersFeedbacksState();
}

class _UsersFeedbacksState extends State<UsersFeedbacks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeedbackCubit>(context)
        .getServiceProviderByServiceId(CacheData.getData(key: "employee_id"));
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
                    "تقيمات العملاء",
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
      body: BlocBuilder<FeedbackCubit, FeedbackStates>(
        builder: (context, state) {
          if (state is FeedbackSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          BlocProvider.of<FeedbackCubit>(context).feedBacks.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: MainColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                    BorderRadius.circular(20),
                                                border:
                                                    Border.all(color: MainColor)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: MainColor,
                                                  size: 15,
                                                ),
                                                Text(
                                                  BlocProvider.of<FeedbackCubit>(
                                                              context)
                                                          .feedBacks[index]
                                                          .rating ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontFamily: "Cairo",
                                                      fontSize: 17,
                                                      color: MainColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  BlocProvider.of<FeedbackCubit>(
                                                              context)
                                                          .feedBacks[index]
                                                          .user
                                                          ?.name ??
                                                      "",
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      fontFamily: "Cairo",
                                                      fontSize: 19,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "$PartImagePath${BlocProvider.of<FeedbackCubit>(context).feedBacks[index].user?.image}"),
                                                radius: 30,
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
                                             BlocProvider.of<FeedbackCubit>(context)
                                                    .feedBacks[index]
                                                    .comment ??
                                                "",
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
                                          timeFromNow(
                                              BlocProvider.of<FeedbackCubit>(
                                                          context)
                                                      .feedBacks[index]
                                                      .createdAt ??
                                                  "0"),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontFamily: "Cairo",
                                            fontSize: 15,
                                            color: MainColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ],
              ),
            );
          } else if (state is FeedbackLoadingState) {
            return const GenerelLoadingPage();
          } else {
            return const NotFoundPage(
              Message: "لا يوجد تقيمات حتي الان",
            );
          }
        },
      ),
    );
  }
}
