import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardLoadingPage extends StatelessWidget {
  const CardLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => LoadingCard(),
              itemCount: 5,
            ),
          )
        ],
      ),
    ));
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.bookmark_border_rounded,
                size: 27,
                color: Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 60,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ],
              ),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
