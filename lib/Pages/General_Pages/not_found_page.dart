import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key, required this.Message,
  });
final  String Message;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200, child: Image.asset("assets/photo/sideface.png")),
            SizedBox(
              height: 20,
            ),
            const Text(
              "لم يتم العثور",
              style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 5,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Text(
                 Message,
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}