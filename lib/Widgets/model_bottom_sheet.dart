import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ازالة من المفضلة؟',
            style: TextStyle(fontFamily: 'cairo', fontSize: 21.0),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context){
                      //       return ;
                      //     }
                      // )
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'name',
                            style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 19.0,
                                color: Colors.grey),
                          ),
                          Text(
                            'service',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 24.0,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Text(
                                  '4.9  | 6,182 تقييم',
                                  style: TextStyle(
                                      fontFamily: 'cairo', color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 180,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: Colors.blue.shade900)),
                  alignment: Alignment.center,
                  child: Text(
                    'نعم،ازالة',
                    style: TextStyle(fontFamily: 'cairo', color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 120,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: Colors.blue.shade900)),
                  alignment: Alignment.center,
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        fontFamily: 'cairo', color: Colors.blue.shade900),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
