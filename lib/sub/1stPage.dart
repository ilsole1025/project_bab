import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const ME =
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "at": "2023.03.08.13:30",
    "interest" : [
      "infj",
      "커피좋아하는나란말야",
      "안녕",
      "나는 짱구야",
      "ㅎㅎ",
      "ㅎㅎㅎㅎㅎ",
      "ㅇㅋㅇㅋㅇㅋ",
    ]
  };
const NEW_LIST = [
  //map타입.key value pair방식(한쌍.짝)
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "111.jpeg",
    "date": "2023.03.08.13:30",
  },
];

class MakingDate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    child: Text("랜덤매칭 찾는중!!!")
                ),
                Icon(Icons.notifications),
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
                    '${ME['at']}\n',
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
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(int.parse("0xFFEBEBEB")),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    width: double.infinity,
                    child: Text("랜덤 매칭 찾기 취소!!!", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ),
                ]
            )
        )
    );
  }
}

class MakeDate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Text("랜덤매칭")
              ),
              Icon(Icons.notifications),
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
                  'at: ${ME['at']}\n',
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
                    },
                  ),
                ),
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

class FirstApp extends StatelessWidget{
  const FirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const newList=NEW_LIST;

    return SafeArea(
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.grey,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            //Icon(Icons.arrow_back),
                            Text("홈")
                          ]
                      ),
                    ),
                    Icon(Icons.notifications),
                  ],
                )
            ),
            body: Column(
              children: [
              Expanded(
              child: ListView.builder(
                itemCount: newList.length,
                itemBuilder: (BuildContext context, int index) {

                  return Container(
                      height: 200,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 39),
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
                                  backgroundImage: AssetImage('../img/${newList[index]['image']}'),
                                  radius: 58.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${newList[index]['name']}',
                                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                                    ),
                                    Text(
                                      '${newList[index]['temperature']}\n',
                                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                                    ),
                                    Text(
                                      '${newList[index]['introduction']}\n',
                                      style: TextStyle(fontSize: 13,color: Colors.black),
                                    ),
                                    Text(
                                      '${newList[ index]['date']}',
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
                                  child: Text("채팅하기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                                  onPressed: (){

                                  },
                                )
                            ),
                    ]
                      ),
                  );
                },
              ),
            ),
    Container(
        margin: EdgeInsets.fromLTRB(10, 39, 10, 39) ,
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
            backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0x338E4444"))), // background (button) color
            shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0x338E4444"))),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          child: Text("랜덤매칭 해보기!!!", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MakeDate())
            );
          },
        )
      ),
      ]
          ),)
        );
  }
}