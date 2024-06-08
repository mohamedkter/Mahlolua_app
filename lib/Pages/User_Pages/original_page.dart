import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/offer_model.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Pages/Loading_Pages/original_loading_page.dart';
import 'package:mahloula/Pages/User_Pages/all_services_page.dart';
import 'package:mahloula/Pages/User_Pages/bookmark_page.dart';
import 'package:mahloula/Pages/User_Pages/specific_offer_page.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Pages/User_Pages/offers_page.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Widgets/custom_all_services.dart';
import 'package:mahloula/Widgets/custom_offer_item.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OriginalPage extends StatelessWidget {
  OriginalPage({required this.name});
  final String name;
  TextEditingController searchController = TextEditingController();

  ///////// Offer Slider Data /////////////
  List<Offer> offers = [
    Offer(id: 2, image: "assets/photo/offer7.jfif", desc: "all done"),
    Offer(id: 3, image: "assets/photo/offerone.jpg", desc: "all done"),
    Offer(id: 4, image: "assets/photo/offertwo.jfif", desc: "all done"),
  ];

//////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  print(TimeOfDay.now());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookmarkPage()));
                },
                icon: Icon(
                  Icons.bookmark_border,
                  size: 27,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsPage()));
                },
                icon: Icon(
                  Icons.notifications_none,
                  size: 27,
                )),
          ],
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TimeOfDay.now().hour<12?
                'صباح الخير':'مساء الخير',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'cairo', fontSize: 16),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 21.0,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OriginalLoadingPage()));
            },
            icon: Icon(
              Icons.account_circle,
              size: 45,
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        labelText: 'بحث',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 24,
                          fontFamily: 'cairo',
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            // services.contains(searchController.text) ? print('success') : Navigator.push(context, MaterialPageRoute(builder: (context){
                            //   return NoResults();
                            // }));

                            GetMethods.getUserOrders(1);
                          },
                          icon: const Icon(
                            Icons.search_rounded,
                            color: Colors.black54,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OffersPage()));
                      },
                      child: Text(
                        'الكل',
                        style: TextStyle(
                            color: MainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'عروض خاصة',
                        style: TextStyle(
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                            color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),

///////////////////////// Offer Slider Section ///////////////////////////////////////////////

                OfferSlider(offers: offers),

///////////////////////////////////////////////////////////////////////////////////

                // CustomOfferItem(
                //   text1: '30%',
                //   text2: 'عروض اليوم',
                //   text3: ' احصل علي عرض لكل طلب, صالح لليوم',
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllServicesPage()));
                      },
                      child: Text(
                        'الكل',
                        style: TextStyle(
                            color: MainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'الخدمات',
                        style: TextStyle(
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                            color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
                CustomAllSercivces()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferSlider extends StatefulWidget {
  const OfferSlider({
    super.key,
    required this.offers,
  });

  final List<Offer> offers;

  @override
  State<OfferSlider> createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  final CarouselController carouselController = CarouselController();

  int currentId = 1;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
             Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpecificOfferPage(offer:widget.offers[currentIndex])));
            },
            child: CarouselSlider(
                items: widget.offers
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              e.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                      currentId = widget.offers[index].id;
                    },
                    aspectRatio: 2,
                    viewportFraction: 1,
                    autoPlay: true,
                    scrollPhysics: const BouncingScrollPhysics())),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: widget.offers.length,
              position: currentIndex,
              decorator:
                  DotsDecorator(activeColor: MainColor, color: Colors.white,activeSize: Size.square(11),size:Size.square(11) ),
            ),
          )
        ],
      ),
    );
  }
}
