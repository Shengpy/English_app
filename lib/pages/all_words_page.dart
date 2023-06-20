
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/english_today.dart';

import '../values/app_colors.dart';
import '../values/app_fonts.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({super.key,required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar:AppBar(
        backgroundColor: AppColors.lightBlue,
        //--shadow
        elevation: 0,
        title: Text(
          'English today',
          style:AppStyles.h3.copyWith(
            color: AppColors.textColor,
          )
        ),
        //---------list--bar
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal:12),
          child: InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,size:50)
            ),
        ),
      ),
    body: Container(
      margin: const EdgeInsets.only(top:10,bottom:10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child:GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

        children: words.map((e)=>Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color:AppColors.primaryColor,
            color: e.isFavorite ? const Color.fromARGB(255, 129, 169, 255):AppColors.primaryColor,
            borderRadius:  const BorderRadius.all(Radius.circular(8)),
          ),
          child:Column(
            children:[ 
              //-------------heart
              Container(
                 alignment: Alignment.centerRight,
                 child: Icon(
                   Icons.favorite,
                   color:e.isFavorite ? Colors.red[400]:Colors.white,
                   size: 50,
                   ),
               ),
              const Spacer(),
              //------------------
              AutoSizeText(
              e.noun??'',
              style: AppStyles.h4.copyWith(
                shadows: const [
                  BoxShadow(
                    color:Colors.black38,
                    offset:Offset(3,2), 
                    blurRadius: 6,
                  )
                 ]
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            const Spacer(),
            const Spacer(),
            ],
          )
        )).toList(),
        )
    ),
    );
  }
}