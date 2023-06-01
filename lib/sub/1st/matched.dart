import 'package:flutter/material.dart';

class Matched extends StatelessWidget {
  var my_info;
  var other_info;

  Matched({
    Key? key,
    this.my_info,
    this.other_info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var matched_interest = <String>[];
    for(var i =0; i<my_info['interest'].length; i++){
      if(other_info['interest'].contains(my_info['interest'][i]))
        matched_interest.add(my_info['interest'][i]);
    }
    if (matched_interest.length == 0)
      matched_interest.add('none');

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
                        Text('매칭 완료',)
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                backgroundImage: AssetImage('../img/${my_info['image']}'),
                                radius: 58.0,
                              ),
                              Text(
                                  '\n${my_info['name']}',
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                              ),
                              Text(
                                '${my_info['temperature']}\n',
                                style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                              ),
                              Text(
                                '${my_info['introduction']}\n',
                                style: TextStyle(fontSize: 13,color: Colors.black),
                              ),
                              Text(
                                '카톡 아이디: ${my_info['kakao']}\n',
                                style: TextStyle(fontSize: 13,color: Colors.black),
                              )
                            ]
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                backgroundImage: AssetImage('../img/${other_info['image']}'),
                                radius: 58.0,
                              ),
                              Text(
                                  '\n${other_info['name']}',
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                              ),
                              Text(
                                '${other_info['temperature']}\n',
                                style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                              ),
                              Text(
                                '${other_info['introduction']}\n',
                                style: TextStyle(fontSize: 13,color: Colors.black),
                              ),
                              Text(
                                '카톡 아이디: ${other_info['kakao']}\n',
                                style: TextStyle(fontSize: 13,color: Colors.black),
                              )
                            ]
                        ),
                      ]
                  ),
                  Container(
                    height: 25,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: matched_interest.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(left: 6, right: 6),
                          width: matched_interest[index].length * 12.0 + 20.0,
                          decoration: BoxDecoration(
                            color: Color(int.parse("0xFFEBEBEB")),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(matched_interest[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
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
                        child: Text("뒤로가기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: (){
                          Navigator.pop(
                            context,
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