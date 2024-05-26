import 'package:flutter/material.dart';

import 'custom_service_item.dart';

class CustomAllSercivces extends StatelessWidget {
  const CustomAllSercivces({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomServiceItem(
              serviceName: 'نظافة',
              imageSource: 'assets/photo/mop.png',
            ),
            CustomServiceItem(
              serviceName: 'غسيل',
              imageSource: 'assets/photo/laundry (1).png',
            ),
            CustomServiceItem(
              serviceName: 'سباكه',
              imageSource: 'assets/photo/leak.png',
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomServiceItem(
              serviceName: 'صيانه',
              imageSource: 'assets/photo/tools.png',
            ),
            CustomServiceItem(
              serviceName: 'نقل',
              imageSource: 'assets/photo/truck.png',
            ),
            CustomServiceItem(
              serviceName: 'دهانات',
              imageSource: 'assets/photo/painting.png',
            ),
          ],
        ),
      ],
    );
  }
}