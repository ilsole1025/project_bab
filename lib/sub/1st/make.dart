import 'package:flutter/material.dart';

import 'making.dart';

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
                  width: 150,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('…랜덤매칭…',)
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
              color: Color(int.parse("0x338E4444")),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage('../img/${ME['image']}'),
                    radius: 58.0,
                  ),
                  Text(
                      '\n${ME['name']}',
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                  Text(
                    '${ME['temperature']}\n',
                    style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                  ),
                  Text(
                    '${ME['introduction']}\n',
                    style: TextStyle(fontSize: 13,color: Colors.black),
                  ),
                  Text(
                    '카톡 아이디: ${ME['kakao']}\n',
                    style: TextStyle(fontSize: 13,color: Colors.black),
                  ),
                  Container(
                    height: 25,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (ME['interest'] as List<String>).length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(left: 6, right: 6),
                          width: (ME['interest'] as List<String>)[index].length * 12.0 + 20.0,
                          decoration: BoxDecoration(
                            color: Color(int.parse("0xFFEBEBEB")),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text((ME['interest'] as List<String>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        );
                        // return Container(
                        //     height: 25,
                        //     width: (ME['interest'] as List<String>)[index].length * 12.0 + 20.0,
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
                        //       child: Text((ME['interest'] as List<String>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        //       onPressed: (){
                        //         (ME['interest'] as List<String>).removeAt(index);
                        //       },
                        //     )
                        // );
                      },
                    ),
                  ),
                  // Container(
                  //     width: double.infinity,
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
                  //       child: Text("관심사 수정!!!", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  //       onPressed: (){
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => ChangeInterest())
                  //         );
                  //       },
                  //     )
                  // ),
                  // SizedBox(
                  //   height: 20,
                  //   width: double.infinity,
                  // ),
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
                        child: Text("랜덤 매칭 시작!!!", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MakingDate())
                          );
                        },
                      )
                  ),
                ]
            )
        )
    );
  }

}