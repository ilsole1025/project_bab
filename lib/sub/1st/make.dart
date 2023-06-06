import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/matchingComplete.dart';

import 'making.dart';
import 'matchingComplete.dart';

import 'package:http/http.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_bab/sub/DbGet.dart';

import 'package:project_bab/widgets/app_large_text.dart';
import 'package:project_bab/widgets/app_text.dart';
/*
var ME =
{
  "name": "딩기리맛때",
  "temperature": "36.9°",
  "introduction": "안녕 나는 딩기리맛때 띰맛때야",
  "image": "111.jpeg",
  "kakao": "donghs@naver.com",
  "interest" : [
    "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp",
    "entp", "esfj", "intj", "istj", "entj", "estp", "estj"
  ]
};
*/



class MakeDate extends StatelessWidget{
  @override


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('랜덤매칭 시작하기',)
                      ]
                  ),
                ),
                Icon(Icons.notifications_outlined, color:Colors.black),
              ],
            )
        ),
        body: Container(


            margin: EdgeInsets.only(left: 10, right: 10, top: 39, bottom: 39),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/texture_bab.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // 투명도 조절
                  BlendMode.dstATop, // 블렌드 모드 설정 (필요에 따라 변경 가능)
                ),
              ),
              // color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final Map<String,dynamic> ME = snapshot.data!;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          backgroundImage: AssetImage('../img/111'),
                          radius: 58.0,
                        ),

                        SizedBox(height: 20,),


                        AppLargeText(text: '${ME['name']}', size:20),
                        AppText(text: "${ME['mannertemp']}\n",
                            size: 16, color: Colors.redAccent),
                        AppText(text: "${ME['introduction']}\n",
                            size: 13, color: Colors.black),

                        Divider(),
                        SizedBox(height: 10,),

                        AppText(text: "나의 관심사"),

                        Container(
                          height: 25,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (ME['interests'] as List<dynamic>).length,
                            itemBuilder: (BuildContext context, int index) {
                              //Color c1 = const Color.fromRGBO(66, 165, 245, 1.0);
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 6, right: 6),
                                width: (ME['interests'] as List<dynamic>)[index].length * 12.0 + 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text((ME['interests'] as List<dynamic>)[index],
                                    style: TextStyle(fontSize: 12, color:Colors.white), textAlign: TextAlign.center),
                              );
                              // return Container(
                              //     height: 25,
                              //     width: (ME['interests'] as List<String>)[index].length * 12.0 + 20.0,
                              //     child: ElevatedButton(
                              //       style: ButtonStyle(
                              //         padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                              //         backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                              //         foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
                              //         shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              //             RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.circular(20),
                              //             )),
                              //       ),
                              //       child: Text((ME['interests'] as List<String>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                              //       onPressed: (){
                              //         (ME['interests'] as List<String>).removeAt(index);
                              //       },
                              //     )
                              // );
                            },
                          ),
                        ),

                        Divider(),
                        SizedBox(height: 10,),

                        AppText(text: "위의 정보로 매칭을 시작합니다.\n", size:12),

                        Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              child: Text("랜덤 매칭 시작하기", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                              onPressed: () async {

                                final HttpsCallableResult result = await FirebaseFunctions
                                    .instance
                                    .httpsCallable("addUserToPool")
                                    .call(<String, dynamic>{'uid': getUid()});

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MakingDate())
                                    // MaterialPageRoute(builder: (context) => matchingComplete())
                                );
                              },
                            )
                        ),
                      ]
                  );
                }
            )
        )
    );
  }

}