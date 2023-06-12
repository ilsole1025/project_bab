import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/rate.dart';

class History extends StatelessWidget {
  var my_info;
  var other_info;

  History({
    Key? key,
    this.my_info,
    this.other_info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var matched_interest = <String>[];
    for(var i =0; i<my_info['interests'].length; i++){
      if(other_info['interests'].contains(my_info['interests'][i]))
        matched_interest.add(my_info['interests'][i]);
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
                        Text('히스토리',)
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
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage('profileImg/${other_info['profileimg']}.jpg'),
                    radius: 58.0,
                  ),
                  Text(
                      '\n${other_info['nickname']}',
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${other_info['mannertemp']}\n',
                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${other_info['introduction']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '카톡 아이디: ${other_info['kakaotalkid']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
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
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage('profileImg/${my_info['profileimg']}.jpg'),
                    radius: 58.0,
                  ),
                  Text(
                      '\n${my_info['nickname']}',
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${my_info['mannertemp']}\n',
                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${my_info['introduction']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '카톡 아이디: ${my_info['kakaotalkid']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
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
                        child: Text("평가하기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Rating(oid: other_info["otherid"]))
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