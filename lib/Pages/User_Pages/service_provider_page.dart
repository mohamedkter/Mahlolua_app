import 'package:flutter/material.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/reservation_page.dart';

class ServiceProviderPage extends StatelessWidget {
   ServiceProviderPage({required this.serviceProvider, super.key});
  final ServiceProvider serviceProvider;
  int price = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius:  const BorderRadius.only(
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.sizeOf(context).height / 3.5,
                color: MainColor,
              ),
            ),
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          serviceProvider.service!.name,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "تقييم",
                                style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              Text(
                                "1.200| 3.9",
                                style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            serviceProvider.user!.name??"No Name",
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
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: Text(
                            serviceProvider.service!.name,
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
                        serviceProvider.minPrice.toString()??"0",
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
                     serviceProvider.desc??"No Des",
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
                padding:
                     const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics:  const NeverScrollableScrollPhysics(),
                    itemCount: serviceProvider.user?.works!.length,
                    gridDelegate:
                         const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: MainColor,
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(image: NetworkImage(serviceProvider.user!.works![index].imageUrl!=""?"https://mahllola.online/public${serviceProvider.user!.works![index].imageUrl}":""),fit: BoxFit.cover)),
                        )),
              ),
            ),
          ],
        ));
  }
}
