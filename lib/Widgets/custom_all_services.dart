import 'package:flutter/material.dart';
import 'package:mahloula/Models/service_model.dart';

import 'custom_service_item.dart';

class CustomAllSercivces extends StatelessWidget {
  List<Service> services = [
    Service(id: 1, name: 'نظافة', desc: "", image: 'assets/photo/mop.png'),
    Service(id: 2, name: 'غسيل', desc: "", image: 'assets/photo/laundry (1).png'),
    Service(id: 3, name: 'سباكه', desc: "", image: 'assets/photo/leak.png'),
    Service(id: 4, name: 'صيانه', desc: "", image: 'assets/photo/tools.png'),
    Service(id: 5, name: 'نقل', desc: "", image: 'assets/photo/truck.png'),
    Service(id: 6, name: 'دهانات', desc: "", image: 'assets/photo/painting.png'),
    Service(id: 7, name: 'نظافة', desc: "", image: 'assets/photo/mop.png'),
    Service(id: 8, name: 'المزيد', desc: "", image: 'assets/photo/mop.png'),
  ];
  CustomAllSercivces({
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
        serviceName: services[index].name,
        imageSource: services[index].image,
      ),
      itemCount: services.length,
    );
    // Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         CustomServiceItem(
    //           serviceName: 'نظافة',
    //           imageSource: 'assets/photo/mop.png',
    //         ),
    //         CustomServiceItem(
    //           serviceName: 'غسيل',
    //           imageSource: 'assets/photo/laundry (1).png',
    //         ),
    //         CustomServiceItem(
    //           serviceName: 'سباكه',
    //           imageSource: 'assets/photo/leak.png',
    //         ),
    //       ],
    //     ),
    //     SizedBox(
    //       height: 8,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         CustomServiceItem(
    //           serviceName: 'صيانه',
    //           imageSource: 'assets/photo/tools.png',
    //         ),
    //         CustomServiceItem(
    //           serviceName: 'نقل',
    //           imageSource: 'assets/photo/truck.png',
    //         ),
    //         CustomServiceItem(
    //           serviceName: 'دهانات',
    //           imageSource: 'assets/photo/painting.png',
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
