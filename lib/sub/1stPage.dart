import 'package:flutter/material.dart';

const NEW_LIST = [
  //map타입.key value pair방식(한쌍.짝)
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
  {
    "name": "딩기리맛때",
    "temperature": "36.9°",
    "introduction": "안녕 나는 딩기리맛때 띰맛때야",
    "image": "image.png",
    "date": "2023.03.08.13:30",
  },
];

class HomeComponent extends StatelessWidget{
  const HomeComponent({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold();
  }
}

class TopBar extends StatelessWidget{
  const TopBar({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold();
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Icon(Icons.arrow_back),
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
                                  backgroundImage: AssetImage('../assets/images/${newList[index]['image']}'),
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
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(int.parse("0xFFEBEBEB")),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            width: double.infinity,
                            child: Text("채팅하기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        ),
                    ]
                      ),
                  );
                },
              ),
            ),
      Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(39),
        decoration: BoxDecoration(
          color: Color(int.parse("0x338E4444")),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: double.infinity,
        child: Text("랜덤매칭 해보기!!!", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),
      ]
          ),)
        );
  }
}