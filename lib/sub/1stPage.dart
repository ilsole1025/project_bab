import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/history.dart';
import 'package:project_bab/sub/1st/matched.dart';
import '1st/make.dart';
//import 'interest.dart';
import 'package:http/http.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:project_bab/sub/4thPage.dart';

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

var OLD_LIST = [
  //map타입.key value pair방식(한쌍.짝)
  {
    "name": "딩기리맛때1",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야1",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때2",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야2",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때3",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야3",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때4",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야4",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때5",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야5",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때6",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야6",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
];
var NEW_LIST = [
  //map타입.key value pair방식(한쌍.짝)
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
    "interest" : [
      "infp", "enfp", "isfp", "infj", "intp", "isfj", "enfj", "istp", "esfp"
    ]
  },
];

// class ChangeInterest extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ChangeInterestState();
//   }
// }
//
// class _ChangeInterestState extends State<ChangeInterest> {
//   var _interest = List.from(ME['interest'] as List<String>);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: 100,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children:[
//                         Text('관심사 수정',)
//                       ]
//                   ),
//                 ),
//                 Icon(Icons.notifications_outlined, color:Colors.black),
//               ],
//             )
//         ),
//       body: Container(
//         padding: EdgeInsets.all(5),
//         margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("나의 관심사", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
//             Container(
//               height: 25,
//               width: double.infinity,
//               margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _interest.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       height: 25,
//                       width: _interest[index].length * 12.0 + 20.0,
//                       margin: EdgeInsets.only(right: 10),
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
//                           backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                           foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
//                           shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               )),
//                         ),
//                         child: Text(_interest[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
//                         onPressed: (){
//                           // (ME['interest'] as List<String>).removeAt(index);
//                           setState(() {
//                             _interest.remove(_interest[index]);
//                           });
//                         },
//                       )
//                   );
//                 },
//               ),
//             ),
//             Container(
//               height: 10,
//               width: double.infinity,
//               color: Color(int.parse("0xFFEBEBEB")),
//               margin: EdgeInsets.only(bottom: 20),
//             ),
//             Expanded(
//                 child: Container(
//                   height: INTEREST.length * 300,
//                   width: double.infinity,
//                   //margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
//                   child: ListView.builder(
//                     itemCount: INTEREST.length,
//                     itemBuilder: (BuildContext context, int idx) {
//                       String key = INTEREST.keys.elementAt(idx);
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children:[
//                           Text(key, style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
//                           Container(
//                             height: 25,
//                             width: double.infinity,
//                             margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
//                             child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: (INTEREST[key] as List<String>).length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Container(
//                                   height: 25,
//                                   width: (INTEREST[key] as List<String>)[index].length * 12.0 + 20.0,
//                                   margin: EdgeInsets.only(right: 10),
//                                   child: ElevatedButton(
//                                     style: ButtonStyle(
//                                       padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
//                                       backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                                       foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
//                                       shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(20),
//                                           )),
//                                     ),
//                                     child: Text((INTEREST[key] as List<String>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
//                                     onPressed: (){
//                                       // (ME['interest'] as List<String>).add((INTEREST[key] as List<String>)[index]);
//                                       setState(() {
//                                         _interest.add((INTEREST[key] as List<String>)[index]);
//                                         _interest = _interest.toSet().toList();
//                                       });
//                                     },
//                                   )
//                               );
//                             },
//                           )
//                         ),
//                       ]
//                     );
//                   }
//                 )
//               )
//             ),
//             Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
//                     backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                     foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
//                     shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         )),
//                   ),
//                   child: Text("수정하기!!", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
//                   onPressed: (){
//                     // print(ME['interest'].runtimeType);
//                     (ME['interest'] as List<String>).clear();
//                     (ME['interest'] as List<String>).addAll(List.from(_interest));
//                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MakeDate()), (route) => route.isFirst);
//                   },
//                 )
//             ),
//           ]
//         )
//       )
//     );
//   }
// }

class FirstApp extends StatelessWidget{
      const FirstApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {

    var newList=NEW_LIST;
    var oldList=OLD_LIST;
    var my_info = ME;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                automaticallyImplyLeading: false,
                title: Row(
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
                    ),
                    /*
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.white70,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [Icon(Icons.settings_outlined)],
                            ),
                          ),
                        ),
                      ),
                    ),
                   */
                   // Icon(Icons.settings_outlined, color:Colors.black),
                  ],
                )
            ),

            body:
            Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Expanded(
              child: ListView.builder(
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
                            itemBuilder: (BuildContext context, int index) {
                              if(index == 0){
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
                                                backgroundImage: AssetImage('../img/${my_info['image']}'),
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Matched(my_info: my_info, other_info: newList[index-1],))
                                        );
                                      },
                                      child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.amber,
                                              backgroundImage: AssetImage('../img/${newList[index-1]['image']}'),
                                            ),
                                            Text(
                                                '${newList[index-1]['name']}',
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
                        color: Color(int.parse("0x338E4444")),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      // color:Color(0xffF5DD9A),

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  backgroundImage: AssetImage('../img/${oldList[index-1]['image']}'),
                                  radius: 58.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${oldList[index-1]['name']}',
                                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                                    ),
                                    Text(
                                      '${oldList[index-1]['temperature']}\n',
                                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                                    ),
                                    Text(
                                      '${oldList[index-1]['introduction']}\n',
                                      style: TextStyle(fontSize: 13,color: Colors.black),
                                    ),
                                    Text(
                                      '${oldList[index-1]['date']}',
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
                                        MaterialPageRoute(builder: (context) => History(my_info: my_info, other_info: oldList[index-1],))
                                    );
                                  },
                                )
                            ),
                    ]
                      ),
                  );
                },
              ),
            ),
      ]
          ),)
        ));
  }
}