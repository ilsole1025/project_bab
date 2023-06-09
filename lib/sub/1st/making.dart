import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_bab/sub/DbGet.dart';


class MakingDate extends StatelessWidget{
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
                        Text('랜덤매칭 찾는 중',)
                      ]
                  ),
                ),
                Icon(Icons.notifications_outlined, color:Colors.black),
              ],
            )
        ),

        body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final Map<String,dynamic> ME = snapshot.data!;
          return Container(
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
                // color: Color(int.parse("0x338E4444")),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      backgroundImage: AssetImage('profileImg/${ME['profileimg']}.jpg'),
                      radius: 58.0,
                    ),
                    Text(
                        '\n${ME['nickname']}',
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                    ),
                    Text(
                      '${ME['mannertemp']} °C\n',
                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                    ),
                    Text(
                      '${ME['introduction']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                    ),
                    Text(
                      '카톡 아이디: ${ME['kakaotalkid']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                    ),
                    Container(
                      height: 25,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (ME['interests'] as List<dynamic>).length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 6, right: 6),
                            width: (ME['interests'] as List<dynamic>)[index].length * 12.0 + 20.0,
                            decoration: BoxDecoration(
                              color: Color(int.parse("0xFFEBEBEB")),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text((ME['interests'] as List<dynamic>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
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
                          child: Text("랜덤 매칭 찾기 취소", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                          onPressed: () async{
                            final HttpsCallableResult result = await FirebaseFunctions
                                .instance
                                .httpsCallable("removeUserFromPool")
                                .call(<String, dynamic>{'uid': getUid()});


                            Navigator.pop(context);
                          },
                        )
                    ),
                  ]
              )
          );
        }
      )
    );
  }
}
