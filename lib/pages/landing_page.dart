import 'package:flutter/material.dart';
// import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_fonts.dart';
// void main() {
//   runApp(
//     const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: LandingPage(),
//     ),
//     );
//   // runApp(const MyApp());
// }
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  static const routeName = '/first-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding( 
        padding: const EdgeInsets.symmetric(horizontal:16),
      child: Column(
        children:[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
              'Welcome to',
              style: AppStyles.h3,
              ),
            ), 
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Engslish',
                  style: AppStyles.h2.copyWith(
                    color: AppColors.blackGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:8),
                  child: Text(
                  'qoutes"',
                  textAlign: TextAlign.right,
                  style: AppStyles.h4.copyWith(height:0.5),
                  ),
                )
              ],
            ) 
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: RawMaterialButton(
                onPressed: (){
                  //--having the return button
                  // Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
    
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
                },
                child: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.blue,
                    size: 100,
                    ),
              ),
            ) 
          ),
      ],
      )
      )
    );
  }
}