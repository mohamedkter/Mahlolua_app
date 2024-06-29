import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/card_loading_page.dart';
import 'package:mahloula/Pages/General_Pages/error_page.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/Credentials_Cubit/credentials_status.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Specific_Service_Page_Cubit/specific_service_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Specific_Service_Page_Cubit/specific_service_page_status.dart';
import 'package:mahloula/Widgets/service_card.dart';
import 'package:mahloula/Pages/User_Pages/service_provider_page.dart';

class SpecificServicePage extends StatefulWidget {
  const SpecificServicePage(
      {Key? key, required this.name, required this.serviceId})
      : super(key: key);
  final String name;
  final int serviceId;
  @override
  State<SpecificServicePage> createState() => _SpecificServicePageState();
}

class _SpecificServicePageState extends State<SpecificServicePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SpecificServicePageCubit>(context)
        .getServiceProviderByServiceId(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 17,
              child: Icon(
                Icons.more_horiz,
              ),
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 27.0,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 30,
                ))
          ],
        ),
        body: BlocBuilder<SpecificServicePageCubit, SpecificServicePageState>(
            builder: ((context, state) {
          if (state is ServicesProviderLoadingStatus) {
            return CardLoadingPage();
          } else if (state is ServicesProviderSuccessStatus) {
            List<ServiceProvider> serviceProviders =
                BlocProvider.of<SpecificServicePageCubit>(context)
                    .serviceProvider;
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                    child: ServiceCard(
                      id: serviceProviders[index].id,
                      image: serviceProviders[index].user!.image ?? "",
                      NumberResidents: serviceProviders[index].total_rates ?? 0,
                      Price: serviceProviders[index].minPrice,
                      ProvidedService: serviceProviders[index].service!.name,
                      rate: double.parse(
                          serviceProviders[index].average_rating ?? "0.0"),
                      ServiceProviderName: serviceProviders[index].user?.name,
                      ToDoFunction: () {
                        print("bookmarked");
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ServiceProviderPage(
                                serviceProvider: serviceProviders[index],
                              )));
                    },
                  ),
                  itemCount: serviceProviders.length,
                ));
          } else {
            return const NotFoundPage(Message:  "اسف هذه الخدمه غير متوفر في الوقت الحالي يرجي المحاوله في وقت قادم",);
          }
        })));
  }
}


