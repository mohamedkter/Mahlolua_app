import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:105,right:10,left:10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'بحث',
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontFamily: 'cairo',
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black54,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
