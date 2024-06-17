import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Loading_Pages/card_loading_page.dart';
import 'package:mahloula/Widgets/service_card.dart';

class Employee {
  final String name;
  final double price;
  final double rate;
  final int numberResidents;
  final String providedService;

  Employee({
    required this.name,
    required this.price,
    required this.rate,
    required this.numberResidents,
    required this.providedService,
  });
}

List<Employee> employees = [
  Employee(
    name: "محمد",
    price: 100.0,
    rate: 4.5,
    numberResidents: 3,
    providedService: "تنظيف المنازل", // Home Cleaning
  ),
  Employee(
    name: "أحمد",
    price: 150.0,
    rate: 5.0,
    numberResidents: 1,
    providedService: "صيانة كهربائية", // Electrical Maintenance
  ),
  Employee(
    name: "سارة",
    price: 80.0,
    rate: 4.0,
    numberResidents: 2,
    providedService: "رعاية أطفال", // Childcare
  ),
  Employee(
    name: "علي",
    price: 120.0,
    rate: 4.8,
    numberResidents: 4,
    providedService: "تركيب اثاث", // Furniture Assembly
  ),
  Employee(
    name: "فاطمة",
    price: 90.0,
    rate: 4.2,
    numberResidents: 1,
    providedService: "خياطة وتفصيل", // Tailoring and Alterations
  ),
  Employee(
    name: "عمر",
    price: 110.0,
    rate: 4.7,
    numberResidents: 3,
    providedService: "بستنة وتنسيق حدائق", // Gardening and Landscaping
  ),
  Employee(
    name: "حنين",
    price: 70.0,
    rate: 3.8,
    numberResidents: 2,
    providedService: "تنظيم المناسبات", // Event Planning
  ),
  Employee(
    name: "خالد",
    price: 130.0,
    rate: 4.9,
    numberResidents: 4,
    providedService:
        "تنظيف السجاد والمفروشات", // Carpet and Upholstery Cleaning
  ),
  Employee(
    name: "ليلى",
    price: 85.0,
    rate: 4.1,
    numberResidents: 1,
    providedService: "دروس خصوصية", // Private Tutoring
  ),
  Employee(
    name: "يوسف",
    price: 105.0,
    rate: 4.6,
    numberResidents: 3,
    providedService: "صيانة السباكة", // Plumbing Maintenance
  ),
  Employee(
    name: "نور",
    price: 95.0,
    rate: 4.3,
    numberResidents: 2,
    providedService: "تصميم ديكور داخلي", // Interior Design
  ),
  Employee(
    name: "كريم",
    price: 115.0,
    rate: 4.8,
    numberResidents: 4,
    providedService: "مكافحة الحشرات", // Pest Control
  ),
  Employee(
    name: "هنا",
    price: 75.0,
    rate: 3.9,
    numberResidents: 1,
    providedService: "ترجمة وثائق", // Document Translation
  ),
  Employee(
    name: "آدم",
    price: 140.0,
    rate: 5.0,
    numberResidents: 3,
    providedService: "دروس تقوية", // Reinforcement Classes
  ),
  Employee(
    name: "مريم",
    price: 80.0,
    rate: 4.0,
    numberResidents: 2,
    providedService: "تصليح أجهزة منزلية", // Appliance Repair
  ),
];

class SearchPage extends SearchDelegate {
  List<Employee> filteredEmployees = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query='';
          },
          icon: Icon(
            Icons.close,
            color: MainColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: MainColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("result");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query != "") {
      filteredEmployees =
          employees.where((element) => element.name.contains(query)||element.providedService.contains(query)||element.rate.toString().startsWith(query)).toList();
      if (filteredEmployees != []) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) => ServiceCard(
                  ServiceProviderName: filteredEmployees[index].name,
                  Price: filteredEmployees[index].price,
                  rate: filteredEmployees[index].rate,
                  NumberResidents: filteredEmployees[index].numberResidents,
                  ProvidedService: filteredEmployees[index].providedService,
                  ToDoFunction: () {})),
        );
      } 
      else{
        return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 200,height: 200,child: Image.asset("assets/photo/sideface.png",fit: BoxFit.cover,),),
              const Text(
                  "Not Found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700),
                ),
            ],
          ),
        ],
      );
      }
    } else {
      return CardLoadingPage();
      // return Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //   child: ListView.builder(
      //       itemCount: employees.length,
      //       itemBuilder: (context, index) => ServiceCard(
      //           ServiceProviderName: employees[index].name,
      //           Price: employees[index].price,
      //           rate: employees[index].rate,
      //           NumberResidents: employees[index].numberResidents,
      //           ProvidedService: employees[index].providedService,
      //           ToDoFunction: () {})),
      // );
    }
  }
}
