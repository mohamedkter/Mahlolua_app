import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class ServiceCard extends StatefulWidget {
  final String? ServiceProviderName;
  final String? image;
  final String? Price;
  final double? rate;
  final int NumberResidents;
  final String ProvidedService;
  final VoidCallback ToDoFunction;
  const ServiceCard({
    super.key,
    required this.ServiceProviderName,
    required this.Price,
    required this.rate,
    required this.NumberResidents,
    required this.ProvidedService,
    required this.ToDoFunction,
    required this.image,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool bookMarkClicked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.black, width: 0.2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: widget.ToDoFunction,
                child: const Icon(Icons.bookmark_border_rounded, size: 27)),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        widget.ServiceProviderName ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          widget.ProvidedService,
                          style: const TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      "${widget.Price}\$",
                      style: const TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 24,
                          color: MainColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        const Text(
                          "تقييم",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                        Text(
                          "${widget.NumberResidents}| ${widget.rate}",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  image: widget.image != null
                      ? DecorationImage(
                          image: NetworkImage(PartImagePath + "${widget.image}"),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage("assets/photo/profileImage.jpg"),
                          fit: BoxFit.cover),
                  color: MainColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            )
          ],
        ),
      ),
    );
  }
}
