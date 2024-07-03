import 'package:flutter/material.dart';
import 'package:mahloula/Models/service_model.dart';

import 'custom_service_item.dart';

class CustomAllSercivces extends StatelessWidget {
  final List<Service> services;
  final int dev;

  CustomAllSercivces({
    required this.services,
    required this.dev,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 110
      ),
      itemBuilder: (context, index) => CustomServiceItem(
        serviceId: services[index].id,
        serviceName: services[index].name,
        imageSource: services[index].image,
      ),
      itemCount: dev==100?services.length%dev:8,
    );
  }
}
