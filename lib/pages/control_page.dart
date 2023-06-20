import 'package:flutter/material.dart';
import 'package:flutter_application_1/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_colors.dart';
import '../values/app_fonts.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    initDefaultValue();
    super.initState();
  }

 initDefaultValue() async{
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter)??5;
    setState(() {
      sliderValue=value.toDouble();
    });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        backgroundColor: AppColors.lightBlue,
        //--shadow
        elevation: 0,
        title: Text(
          'Your control',
          style:AppStyles.h3.copyWith(
            color: AppColors.textColor,
          )
        ),
        //---------list--bar
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal:12),
          child: InkWell(
            onTap:() async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,size:50)
            ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
          child: Column(
            children:[
              const Spacer(),
              Text(
                'How much a number word at once',
                style:AppStyles.h4.copyWith(
                 color:AppColors.lightGrey,
                 fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                '${sliderValue.toInt()}',
                style:AppStyles.h1.copyWith(
                 color:AppColors.primaryColor,
                 fontSize: 150,
                ),
              ),
              Slider(
                value:sliderValue,
                min:5,
                max:100,
                divisions:100,
                activeColor:AppColors.primaryColor,
                inactiveColor: AppColors.primaryColor,
                onChanged: (value){
                  setState(() {
                    sliderValue=value;
                  });
                },
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding:const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'slide to set',
                  style:AppStyles.h5.copyWith(
                   color:AppColors.textColor,
                  ),
                ),
              ),
              const Spacer(),
              const Spacer(),
            ], 
          ),
        ),
    );
  }
}