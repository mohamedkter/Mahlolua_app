import 'package:flutter/material.dart';

import '../../Constants/Color_Constants.dart';

class EditProfile extends StatefulWidget {
   EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController DateController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                const Text(
                  "تعديل الملف ",
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
                      color: MainColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: 30,
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(label: 'الاسم الأول'),
              SizedBox(height: 16),
              _buildTextField(label: 'اسم العائلة'),
              SizedBox(height: 16),
              _buildTextField(icon:Icons.date_range,con: DateController ,
                  fun: ()
                  {
                    showDatePicker(context: context, firstDate: DateTime(1960), lastDate: DateTime(2027)).then((value)
                    {
                      String x = value.toString();

                      DateController.text = x.substring(0,10);
                    });
                    }
                  ,label: 'تاريخ الميلاد'),
              SizedBox(height: 16),
              _buildTextField(icon:Icons.email,label: 'البريد الإلكتروني'),
              SizedBox(height: 16),
              _buildPhoneNumberField(),
              SizedBox(height: 16),
              _buildTextField(label: 'المحافظة'),
              SizedBox(height: 16),
              _buildGenderField(),
              SizedBox(height: 16),
              _buildTextField(label: 'العنوان التفصيلي'),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor, // Set the background color to blue
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save edits
                  }
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10.0),
                  child: Text('حفظ التعديلات',style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 21.0,
                    color: Colors.white
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildPhoneNumberField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(

        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/photo/download.jpg',
              width: 20,
              height: 20,
            ),
          ),
          suffixText: '+20 ',
          labelText: 'رقم الهاتف',
          labelStyle: TextStyle(
              fontFamily: 'cairo',
              color: Colors.grey[500]
          ),
          fillColor: Colors.grey[200],
          filled: true,
          border :InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.1
              )
          ),
          focusedBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال رقم الهاتف';
          }
          return null;
        },
      ),
    );
  }

   Widget _buildTextField({IconData? icon,VoidCallback? fun,TextEditingController? con ,required String label}) {
     return Directionality(
       textDirection: TextDirection.rtl,
       child: TextFormField(
         controller: con,
         decoration: InputDecoration(
           suffixIcon: IconButton(onPressed: fun,
               icon: Icon(icon,color: Colors.grey[500],)),
           labelText: label,
           border: InputBorder.none,
           enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
             borderSide: BorderSide(
               color: Colors.grey,
               width: 0.1
             )
           ),
           focusedBorder: InputBorder.none,
           labelStyle: TextStyle(
             fontFamily: 'cairo',
             color: Colors.grey[500]
           ),
           fillColor: Colors.grey[200],
           filled: true,
         ),
         validator: (value) {
           if (value == null || value.isEmpty) {
             return 'الرجاء إدخال $label';
           }
           return null;
         },
       ),
     );
   }

  Widget _buildGenderField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _genderController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'الجنس',
          labelStyle: TextStyle(
              fontFamily: 'cairo',
              color: Colors.grey[500]
          ),
          fillColor: Colors.grey[200],
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.1
              )
          ),
          focusedBorder: InputBorder.none,
          suffixIcon: DropdownButton<String>(
            icon: Icon(Icons.expand_more_sharp,size: 30,),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
                _genderController.text = newValue!;
              });
            },
            items: <String>['ذكر', 'أنثى'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء اختيار الجنس';
          }
          return null;
        },
      ),
    );
  }
}
