import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class CustomBottomAppBar extends StatelessWidget {

final void Function() buttonFunction;
final String buttonText;
  const CustomBottomAppBar({
    super.key, required this.buttonFunction, required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:MainColor,
                    shadowColor: Colors.black,
                    elevation: 1,
                    fixedSize: Size(MediaQuery.of(context).size.width/1.2, 50)),
                onPressed: buttonFunction,
                child:  Text(
                  buttonText,
                  style:const TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 18,
                    color: Color.fromARGB(255, 241, 242, 243),
                  ),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}