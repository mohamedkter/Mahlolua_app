import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/service_model.dart';
import 'package:mahloula/Models/sponsor_model.dart';
import 'package:mahloula/Pages/Loading_Pages/original_loading_page.dart';
import 'package:mahloula/Pages/User_Pages/all_services_page.dart';
import 'package:mahloula/Pages/User_Pages/bookmark_page.dart';
import 'package:mahloula/Pages/User_Pages/search_page.dart';
import 'package:mahloula/Pages/User_Pages/specific_offer_page.dart';
import 'package:mahloula/Pages/General_Pages/notifications_page.dart';
import 'package:mahloula/Pages/User_Pages/offers_page.dart';
import 'package:mahloula/Pages/General_Pages/user_notification_page.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Widgets/custom_all_services.dart';
import 'package:mahloula/Widgets/custom_offer_item.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Services/Notification/NotificationsServices.dart';

class OriginalPage extends StatelessWidget {
  OriginalPage(
      {required this.name, required this.services, required this.sponsors});
  final String name;
  TextEditingController searchController = TextEditingController();
  /////////// Services Data /////////////
  final List<Service> services;
  ///////// Offer Slider Data /////////////
  final List<Sponsor> sponsors;
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
                          builder: (context) =>
                              UserNotificationSettingsScreen()));
                },
                icon: const Icon(
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
                TimeOfDay.now().hour < 12 ? 'صباح الخير' : 'مساء الخير',
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
          CacheData.getData(key: "image") == null
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle,
                    size: 45,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "$PartImagePath${CacheData.getData(key: "image")}"),
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
                  child: GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: SearchPage());
                    },
                    child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: Color(0xffB1B1B1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "بحث",
                              style: TextStyle(
                                  fontFamily: 'cairo',
                                  fontSize: 17.0,
                                  color: Color(0xffB1B1B1)),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Color(0xffF5F5F5))),
                  ),
                ),
                const SizedBox(
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
                                builder: (context) => OffersPage(sponsors: sponsors,)));
                      },
                      child: const Text(
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

                OfferSlider(offers: sponsors),

///////////////////////////////////////////////////////////////////////////////////

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllServicesPage(services: services,)));
                      },
                      child: const Text(
                        'الكل',
                        style: TextStyle(
                            color: MainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                const SizedBox(
                  height: 10,
                ),
                CustomAllSercivces(
                  services: services,
                  dev: 8,
                )
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

  final List<Sponsor> offers;

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
                      builder: (context) => SpecificOfferPage(
                          offer: widget.offers[currentIndex])));
            },
            child: CarouselSlider(
                items: widget.offers
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              PartImagePath + e.image,
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
              decorator: const DotsDecorator(
                  activeColor: MainColor,
                  color: Colors.white,
                  activeSize: Size.square(11),
                  size: Size.square(11)),
            ),
          )
        ],
      ),
    );
  }
}
