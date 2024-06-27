import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "سياسة الخصوصية",
                style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/photo/logo.png"),
                    ),
                    color: MainColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 30,
                height: 30,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 22, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrivacyPolicySection(
                number: ".1",
                title: "أنواع البيانات التي نجمعها",
                content:
                    " سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعه سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعها.",
              ),
              PrivacyPolicySection(
                number: ".2",
                title: "استخدام بيانات الشخصية",
                content:
                    " سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعه سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعها.",
              ),
              PrivacyPolicySection(
                number: ".3",
                title: "كشف بياناتك الشخصية",
                content:
                    " سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعه سياسات الخصوصية تشرح كيفية جمع، استخدام، وحماية بياناتك الشخصية. يجب أن تكون السياسات واضحة وشاملة لتغطية جميع الجوانب. هذا القسم يقدم معلومات عن الأنواع المختلفة من البيانات التي قد نجمعها.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  final String number;
  final String title;
  final String content;

  const PrivacyPolicySection({
    required this.number,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  height: 1.22,
                  letterSpacing: -0.40799999237060547,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    height: 1.22,
                    letterSpacing: -0.40799999237060547,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              height: 1.47,
              letterSpacing: -0.40799999237060547,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
