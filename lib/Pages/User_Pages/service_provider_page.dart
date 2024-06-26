import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Functions/date_converter.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Models/feedback_model.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/General_Pages/error_page.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_cubit.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_states.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/reservation_page.dart';
import 'package:full_screen_image/full_screen_image.dart';

class ServiceProviderPage extends StatefulWidget {
  ServiceProviderPage({required this.serviceProvider, super.key});
  final ServiceProvider serviceProvider;

  @override
  State<ServiceProviderPage> createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  int price = 30;
  @override
  void initState() {
    BlocProvider.of<FeedbackCubit>(context)
        .getServiceProviderByServiceId(widget.serviceProvider.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MainColor,
                        shadowColor: Colors.black,
                        elevation: 1,
                        fixedSize: Size(170, 50)),
                    onPressed: () {
                      Order obj = Order();
                      obj.price = price;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReservationPage(obj: obj)));
                    },
                    child: const Text(
                      "حجز معاينه",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 20,
                        color: Color.fromARGB(255, 241, 242, 243),
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfff1e7ff),
                      fixedSize: Size(170, 50),
                      shadowColor: Colors.black,
                      elevation: 1,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "راسل",
                      style: TextStyle(
                        //backgroundColor: Color(0xfff1e7ff),
                        fontFamily: "Cairo",
                        fontSize: 20,
                        color: Color(0xff31589B),
                      ),
                    ))
              ],
            ),
          ),
        ),
        body: BlocBuilder<FeedbackCubit, FeedbackStates>(
            builder: (context, state) {
          if (state is FeedbackSuccessState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 3.5,
                    color: MainColor,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.bookmark_added_outlined,
                              size: 35,
                            ),
                            Text(
                              widget.serviceProvider.service!.name,
                              style: const TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "تقييم",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    "${widget.serviceProvider.total_rates}| ${widget.serviceProvider.average_rating}",
                                    style: const TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                widget.serviceProvider.user!.name ?? "No Name",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Cairo",
                                  fontSize: 23,
                                  color: MainColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "النزله ,اسيوط",
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3)),
                              child: Text(
                                widget.serviceProvider.service!.name,
                                style: const TextStyle(
                                  backgroundColor: Color(0xfff1e7ff),
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  color: MainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "سعر المعاينه",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 15,
                                color: Color.fromARGB(255, 104, 101, 101),
                              ),
                            ),
                            Text(
                              widget.serviceProvider.minPrice.toString() ?? "0",
                              style: const TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 35,
                                  color: MainColor,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Divider(
                          color: Color(0xfff1e7ff),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          "معلومات عني",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ReadMoreText(
                            readMoreAlign: AlignmentDirectional.topEnd,
                            readMoreTextStyle: const TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 20,
                                color: MainColor,
                                fontWeight: FontWeight.bold),
                            widget.serviceProvider.desc ?? "No Des",
                            numLines: 2,
                            readMoreText: "المزيد  ...  ",
                            readLessText: "اخفاء",
                            style: const TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الكل",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 18,
                                color: MainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "صور و فيديوهات",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.serviceProvider.user?.works!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => FullScreenWidget(
                              disposeLevel: DisposeLevel.High,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: MainColor,
                                    borderRadius: BorderRadius.circular(25),
                                    image: widget.serviceProvider.user!.works![index].imageUrl!=null?DecorationImage(
                                        image: NetworkImage(widget
                                                    .serviceProvider
                                                    .user!
                                                    .works![index]
                                                    .imageUrl !=
                                                ""
                                            ? "https://mahllola.online/public${widget.serviceProvider.user!.works![index].imageUrl}"
                                            : ""),
                                        fit: BoxFit.cover):DecorationImage(image: AssetImage("assets/photo/notfoundimage.jpg"),fit: BoxFit.cover)),
                              ),
                            )),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "تقييم",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          " ${widget.serviceProvider.total_rates}| ${widget.serviceProvider.average_rating}",
                          style: const TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: BlocProvider.of<FeedbackCubit>(context)
                            .feedBacks
                            .length,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Container(
                                height: 150,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  PartImagePath +
                                                      "${BlocProvider.of<FeedbackCubit>(context).feedBacks[index].user?.image}"),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        "${timeFromNow(BlocProvider.of<FeedbackCubit>(context).feedBacks[index].createdAt ?? "0")}",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            );
          } else if (state is FeedbackLoadingState) {
            return GenerelLoadingPage();
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 3.5,
                    color: MainColor,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.bookmark_added_outlined,
                              size: 35,
                            ),
                            Text(
                              widget.serviceProvider.service!.name,
                              style: const TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "تقييم",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    "${widget.serviceProvider.total_rates}| ${widget.serviceProvider.average_rating??"0.0"}",
                                    style: const TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                widget.serviceProvider.user!.name ?? "No Name",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Cairo",
                                  fontSize: 23,
                                  color: MainColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "النزله ,اسيوط",
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              child: Text(
                                widget.serviceProvider.service!.name,
                                style: const TextStyle(
                                  backgroundColor: Color(0xfff1e7ff),
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  color: MainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "سعر المعاينه",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 15,
                                color: Color.fromARGB(255, 104, 101, 101),
                              ),
                            ),
                            Text(
                              widget.serviceProvider.minPrice.toString() ?? "0",
                              style: const TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 35,
                                  color: MainColor,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Divider(
                          color: Color(0xfff1e7ff),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          "معلومات عني",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ReadMoreText(
                            readMoreAlign: AlignmentDirectional.topEnd,
                            readMoreTextStyle: const TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 20,
                                color: MainColor,
                                fontWeight: FontWeight.bold),
                            widget.serviceProvider.desc ?? "No Des",
                            numLines: 2,
                            readMoreText: "المزيد  ...  ",
                            readLessText: "اخفاء",
                            style: const TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الكل",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 18,
                                color: MainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "صور و فيديوهات",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.serviceProvider.user?.works!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => FullScreenWidget(
                              disposeLevel: DisposeLevel.Medium,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: MainColor,
                                    borderRadius: BorderRadius.circular(25),
                                    image: widget.serviceProvider.user!.works![index].imageUrl!=null?DecorationImage(
                                        image: NetworkImage(widget
                                                    .serviceProvider
                                                    .user!
                                                    .works![index]
                                                    .imageUrl !=
                                                ""
                                            ? "https://mahllola.online/public${widget.serviceProvider.user!.works![index].imageUrl}"
                                            : ""),
                                        fit: BoxFit.cover):DecorationImage(image: AssetImage("assets/photo/notfoundimage.jpg"),fit: BoxFit.cover)),
                              ),
                            )),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
