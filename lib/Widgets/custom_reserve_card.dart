import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';


class CustomReserveCard extends StatefulWidget {
  const CustomReserveCard({
    super.key, required this.index, required this.color,
  });

  final Color color;
  final int index;
  @override
  State<CustomReserveCard> createState() => _CustomReserveCardState();
}

class _CustomReserveCardState extends State<CustomReserveCard> {
  bool isTabed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: Colors.white38,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.black, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/photo/apple.png'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "محمد محمود",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "صيانه تكيف",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: 90,
                        height: 37,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: widget.color,
                        ),
                        child: Center(
                          child: checkStatus(widget.index)
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  )
                ],
              ),
              isTabed
                  ? Directionality(
                textDirection: TextDirection.rtl,
                    child: Text(
                        'Hello, Mohamed ali Welcome to my fucking details',
                        style: TextStyle(fontFamily: 'cairo', fontSize: 17),
                      ),
                  )
                  : Text(''),
              IconButton(
                onPressed: () {
                  setState(() {
                    isTabed = !isTabed;
                  });
                },
                icon: !isTabed
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      )
                    : Icon(
                        Icons.keyboard_arrow_up,
                        size: 40,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Text checkStatus(int ind){
    if(ind == 0){
      return 
        Text(
          'ملغي',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'cairo',
              fontSize: 17),
        );
    }
    else if(ind == 1){
      return
        Text(
          'مكتمل',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'cairo',
              fontSize: 17),
        );
    }
    else{
      return
        Text(
          'قادم',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'cairo',
              fontSize: 17),
        );
    }
  }
}
