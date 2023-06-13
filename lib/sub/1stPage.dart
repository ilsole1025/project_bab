import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/history.dart';
import '1st/make.dart';
import 'package:project_bab/sub/DbGet.dart';

import '1st/matched.dart';

import 'dart:developer';


class FirstApp extends StatefulWidget {
  const FirstApp({Key? key}) : super(key: key);

  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  List<Map<String, dynamic>> newList = [], oldList = [];


  Future<Map<String, dynamic>> initializewithgetUser() async {
    newList = await getMatched();
    oldList = newList;
    return await getUser();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                automaticallyImplyLeading: false,
                /*title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text('홈',)
                          ]
                      ),
                    )
                  ],
                )*/
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/blacklogo.png',
                        width: 90,
                        height: 90,
                      ),
                    ])
            ),

            body:
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: initializewithgetUser(),
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final Map<String, dynamic> my_info = snapshot.data!;
                          my_info['image'] = "profileImg/${my_info['profileimg']}.jpg";
                          return ListView.builder(
                            itemCount: oldList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if(index == 0){
                                return Container(
                                    height: 80,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: newList.length + 1,
                                        itemBuilder: (BuildContext context, int idx) {
                                          if(idx == 0){
                                            return Container(
                                                margin: EdgeInsets.only(right: 20),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0)),
                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0x00FFFFFF"))),
                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                                                      shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0x00FFFFFF"))),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => MakeDate())
                                                      );
                                                    },
                                                    child: Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor: Colors.amber,
                                                            backgroundImage: AssetImage(my_info['image']),
                                                            child: Text(
                                                                '+',
                                                                style: TextStyle(fontSize: 20),
                                                                textAlign: TextAlign.center
                                                            ),
                                                          ),
                                                          Text(
                                                            //'${my_info['name']}',
                                                              '랜덤 매칭',
                                                              style: TextStyle(fontSize: 10),
                                                              textAlign: TextAlign.center
                                                          ),
                                                        ]
                                                    )
                                                ));
                                          }
                                          return Container(
                                              margin: EdgeInsets.only(right: 20),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0)),
                                                    backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0x00FFFFFF"))),
                                                    foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
                                                    shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0x00FFFFFF"))),
                                                  ),
                                                  onPressed: () {
                                                    // log('myUid: ${my_info['uid']}, otherUid: ${newList[idx-1]['otherid']}, name: ${my_info['nickname']}, temperature: ${my_info['mannertemp']}, introduction: ${my_info['introduction']},image: ${'profileImage/${my_info['profileimage']}.jpg'}, kakao: ${my_info['kakaotalkid']}, interest : ${my_info['관심사']},');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => Matched(
                                                          myUid: my_info['uid'],
                                                          otherUid: newList[idx-1]['otherid'],
                                                          my_info: {
                                                            "name": my_info['nickname'],
                                                            "temperature": my_info['mannertemp'],
                                                            "introduction": my_info['introduction'],
                                                            "image": 'profileImg/${my_info['profileimg']}.jpg',
                                                            "kakao": my_info['kakaotalkid'],
                                                            "interest" : my_info['관심사'],
                                                          },
                                                        ))
                                                    );
                                                  },
                                                  child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor: Colors.amber,
                                                          backgroundImage: AssetImage('profileImg/${newList[idx-1]['profileimg']}.jpg'),
                                                        ),
                                                        Text(
                                                            '${newList[idx-1]['nickname']}',
                                                            style: TextStyle(fontSize: 10),
                                                            textAlign: TextAlign.center
                                                        ),
                                                      ]
                                                  )
                                              ));
                                        }
                                    )
                                );
                              }

                              return Container(
                                height: 200,
                                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Color(int.parse("0x338E4444")),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    image: AssetImage('img/texture_bab.jpg'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3), // 투명도 조절
                                      BlendMode.dstATop, // 블렌드 모드 설정 (필요에 따라 변경 가능)
                                    ),
                                  ),
                                ),
                                // color:Color(0xffF5DD9A),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(width: 30),
                                            CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              backgroundImage: AssetImage('profileImg/${oldList[index-1]['profileimg']}.jpg'),
                                              radius: 58.0,
                                            ),
                                            Container(width: 30),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${oldList[index-1]['nickname']}',
                                                    style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                                                ),
                                                Text(
                                                  '${oldList[index-1]['mannertemp']} °C\n',
                                                  style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                                                ),
                                                Text(
                                                  '${oldList[index-1]['introduction']}\n',
                                                  style: TextStyle(fontSize: 13,color: Colors.black),
                                                ),
                                                Text(
                                                  '${oldList[index-1]['timestamp']}',
                                                  style: TextStyle(fontSize: 13,color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      Container(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
                                              shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  )),
                                            ),
                                            child: Text("히스토리 보기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                                            onPressed: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => History(my_info: my_info, other_info: oldList[index-1]))
                                              );
                                            },
                                          )
                                      ),
                                    ]
                                ),
                              );
                            },
                          );
                        }
                      )
                    ),
                  ]
              ),)
        ));
  }
}