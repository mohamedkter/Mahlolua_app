import 'package:flutter/material.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/reservation_page.dart';

class ServiceProviderPage extends StatelessWidget {
   ServiceProviderPage({this.nameSerivce, super.key});
  final String? nameSerivce;
  int price = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius:  BorderRadius.only(
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
                      Order obj = Order(
                          price: price,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReservationPage(object: obj)));
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
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.bookmark_added_outlined,
                          size: 35,
                        ),
                        Text(
                          nameSerivce!,
                          style: TextStyle(
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
                        Text(
                          "محمد محمود",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "Cairo",
                            fontSize: 23,
                            color: MainColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: Text(
                            nameSerivce!,
                            style: TextStyle(
                              backgroundColor: Color(0xfff1e7ff),
                              fontFamily: "Cairo",
                              fontSize: 15,
                              color: MainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "سعر المعاينه",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Color.fromARGB(255, 104, 101, 101),
                          ),
                        ),
                        Text(
                          " 30",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 35,
                              color: MainColor,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(
                      color: Color(0xfff1e7ff),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "معلومات عني",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ReadMoreText(
                        readMoreAlign: AlignmentDirectional.topEnd,
                        readMoreTextStyle: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 20,
                            color: MainColor,
                            fontWeight: FontWeight.bold),
                        "انا احمد حسين، فنى اعمال سباكة صحيه وعامة من النزلة اسيوط . وعملت على الكثير من المشاريع على التطبيق وحصلت على تقيمم جيد من العملاء السابقين لقاء خدماتي ",
                        numLines: 2,
                        readMoreText: "المزيد  ...  ",
                        readLessText: "اخفاء",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
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
                     EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics:  NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MainColor),
                        )),
              ),
            ),
          ],
        ));
  }
}
