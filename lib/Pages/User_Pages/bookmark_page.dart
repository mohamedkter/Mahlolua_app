import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/service_provider_page.dart';
import 'package:mahloula/Widgets/model_bottom_sheet.dart';
import 'package:mahloula/Widgets/service_card.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  Color colorOfContainer = Colors.white;
  Color colorOfText = Colors.blue.shade900;
  List<String> listOfServicesName = [
    'الكل',
    'دهانات',
    'صيانة',
    'نظافة',
    'نقل',
    'غسيل',
    'سباكه',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            'التفضيلات',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 27.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 85,
                        height: 35,
                        decoration: BoxDecoration(
                            color: colorOfContainer,
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(color: Colors.blue.shade900)),
                        alignment: Alignment.center,
                        child: Text(
                          listOfServicesName[index],
                          style: TextStyle(
                              fontFamily: 'cairo', color: Colors.blue.shade900),
                        ),
                      ),
                    );
                  },
                  itemCount: listOfServicesName.length,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                        child: ServiceCard(
                          image: "",
                          NumberResidents: 1200,
                          Price: "125",
                          ProvidedService: "صيانه تكيف",
                          rate: 3.5,
                          ServiceProviderName: "محمد محمود",
                          ToDoFunction: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet();
                              },
                            );
                          },
                        ),
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>  ServiceProviderPage(serviceProvider: null,)));
                        },
                      ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 0,
                    ),
                itemCount: 10),
          )
        ],
      ),
    );
  }
}
