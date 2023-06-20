import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application_1/model/english_today.dart';
import 'package:flutter_application_1/pages/all_words_page.dart';
import 'package:flutter_application_1/pages/control_page.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_fonts.dart';
import 'package:flutter_application_1/values/share_keys.dart';
import 'package:flutter_application_1/wigets/app_button.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(
//     const MaterialApp(
//     home: HomePage(),
//     ),
//     );
//   // runApp(const MyApp());
// }
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;
  late PageController _pageController;

  List<EnglishToday> words=[];
  
  List<int> fixedListRandom({int len=1,int max=120,int min=1}){
    if(len>max || len<min){
      return [];
    }
    List<int> newList=[];

    Random random=Random();
    int count=1;
    while(count <= len){
      int val= random.nextInt(max);
      if(newList.contains(val)){
        continue;
      }else{
        newList.add(val);
        count++;
      }
    }
    return newList;
  }
  
  getEnglishToday() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter)??5;
    List<String> newList=[];
    List<int> rans=fixedListRandom(len:len,max:nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words=newList.map((e)=>EnglishToday(
      noun:e,
      )).toList();
    });
  }

final GlobalKey<ScaffoldState> _scaffoldkey= GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //width of controler page
    _pageController=PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      key:_scaffoldkey,
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
        leading: InkWell(
          onTap:(){
            _scaffoldkey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu_outlined,size:50)
          ),
      ),
      body: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          //----------------hehe top hacker
          Container(
            height: size.height*1/10,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text(
              '"Hehe top hacker"',
              style: AppStyles.h5,
            ),
            ),

          //------------------------
          SizedBox(
            height: size.height*2/3,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index){
                setState((){
                  _currentIndex=index;
                });
              },
              itemCount: words.length,
              itemBuilder: (context,index){
                String firstLetter= words[index].noun != null ? words[index].noun! :'';
                String leftLetter= firstLetter!=''?firstLetter.substring(1,firstLetter.length):'';
                firstLetter=firstLetter!=''?firstLetter.substring(0,1).toUpperCase():'';

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular((24))),
                    elevation: 4,
                    
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      splashColor: Colors.transparent,
                      onDoubleTap:(){
                        setState(() {
                          words[index].isFavorite=!words[index].isFavorite;
                        });
                      },

                      child: Container(
                          padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Container(
                              alignment: Alignment.centerRight,
                              // child: Icon(
                              //   Icons.favorite,
                              //   color:words[index].isFavorite ? Colors.red[400]:Colors.white,
                              //   size: 50,
                              //   ),
                              child: LikeButton(
                                onTap:(bool isLiked) async{
                                  setState(() {
                                    words[index].isFavorite=!words[index].isFavorite;
                                  });
                                  return words[index].isFavorite;
                                },

                                isLiked: words[index].isFavorite,
                                size:50,
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                            ),
                            RichText(
                              maxLines: 1, //one line 
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: firstLetter,
                                style: const TextStyle(
                                  fontFamily: FontFamily.sen,
                                  fontSize: 89,
                                  fontWeight: FontWeight.bold,
                                  shadows:[
                                    BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(3,6),
                                      blurRadius: 6,
                                    )
                                  ] 
                                ),
                                children:[
                                  TextSpan(
                                    text:leftLetter,
                                    style: const TextStyle(
                                    fontFamily: FontFamily.sen,
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                      shadows:[
                                        BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(3,6),
                                          blurRadius: 6,
                                        ),
                                      ] 
                                    ),
                                  )  
                                ],
                                 
                              )
                            ),
                            // const Text('I think it is the target'),
                          ]
                        )
                      ),
                    ),
                  ),
                );
              }),
          ),
          //----------------------indicator
          _currentIndex >=5 ? buildShowMore():
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:24),
            child: SizedBox(
              height:size.height*1/11,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  child:ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: words.length,
                    itemBuilder: (context,index){
                      return buildIndicator(index ==_currentIndex, size);
                    },
                  )
            
                ),
            ),
          ),
          ], 
        ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getEnglishToday();
        },
        child: const Icon(Icons.refresh),
      ),
      
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:[
             Padding(
               padding: const EdgeInsets.only(top:24,left:16),
               child: Text(
                 'Your mind',
                 style: AppStyles.h3.copyWith(color: AppColors.textColor),
               ),
             ),
             //-------------button 1
             Padding(
               padding: const EdgeInsets.symmetric(vertical:24),
               child: AppButton(label: 'Favorites', onTap: (){
             
               }),
             ),
             //--------------button 2
              Padding(
               padding: const EdgeInsets.symmetric(vertical:24),
               child: AppButton(
                label: 'Your control', 
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(_)=> const ControlPage()),
                  );
               }),
             ), 
           ]
          )
        ),
      ),
    );
  }
  Widget buildIndicator(bool isActive,Size size){
   return AnimatedContainer(
     duration: const Duration(milliseconds: 500),
     height: 8,
     margin:const EdgeInsets.symmetric(horizontal:12),
     width:isActive? size.width*1/5 : 24,
     decoration: BoxDecoration(
       color: isActive? AppColors.lightBlue: AppColors.lightGrey,
       borderRadius: const BorderRadius.all(Radius.circular(12)),
       boxShadow: const [
        BoxShadow(
          color:Colors.black38,
          offset:Offset(2,3), 
          blurRadius: 3,
        )
       ]
     ),
   );
 }
  Widget buildShowMore(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal:24,vertical:12),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color:AppColors.primaryColor,
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(_)=>AllWordsPage(words:words) ,
                ),
            );
          },
          
          splashColor: Colors.black38,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
             padding: const EdgeInsets.symmetric(horizontal:24,vertical:12),
             child:const Text('Show more',style:AppStyles.h5),
          ),
        ),
      ),
    );
  }
}