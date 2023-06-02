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
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage('../img/${other_info['image']}'),
                    radius: 58.0,
                  ),
                  Text(
                      '\n${other_info['name']}',
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${other_info['temperature']}\n',
                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${other_info['introduction']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '카톡 아이디: ${other_info['kakao']}\n',
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
                    backgroundImage: AssetImage('../img/${my_info['image']}'),
                    radius: 58.0,
                  ),
                  Text(
                      '\n${my_info['name']}',
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${my_info['temperature']}\n',
                      style: TextStyle(fontSize: 16,color: Color(int.parse("0xff8E4444"))),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '${my_info['introduction']}\n',
                      style: TextStyle(fontSize: 13,color: Colors.black),
                      textAlign: TextAlign.center
                  ),
                  Text(
                      '카톡 아이디: ${my_info['kakao']}\n',
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
                        child: Text("날짜 선택하기!!", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if(date == null)
                            return;
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if(time == null)
                            return;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  title: Column(
                                    children: <Widget>[
                                      new Text("날짜 확인"),
                                    ],
                                  ),
                                  //
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${date?.year}.${date?.month}.${date?.day}, ${time?.hour}:${time?.minute}",
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new ElevatedButton(
                                      child: new Text("확인"),
                                      onPressed: () {
                                        // 여기에 넣어 주세요!! - date, time에 각각 만날 날짜 시간이 넣어져 있음
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                      },
                                    ),
                                    new ElevatedButton(
                                      child: new Text("취소"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                  ),
                ]
            )
        )
    );
  }

}