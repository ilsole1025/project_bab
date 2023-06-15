import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_bab/sub/DbGet.dart';

const MaterialColor whiteP = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

class Rating extends StatefulWidget {
  Rating({
    Key? key,
    required this.oid,
  }) : super(key: key);

  final String oid;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late double _rating;
  late String oid;
  String inputText = '';

  double _initialRating = 3.0;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    oid = widget.oid;
    _rating = _initialRating;
  }

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
                        Text('평가하기', style: TextStyle(color:Colors.black),)
                      ]
                  ),
                ),
              ],
            )
        ),
          body:Container(
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
            child: Column(
              children: [
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  _heading('평가'),
                  _ratingBar(1),
                  SizedBox(height: 20.0),
                  Text(
                    '$_rating 점',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.0),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: '밥약에 대한 후기를 남겨주세요',
                    ),
                    onChanged: (text) {
                      setState(() {
                        inputText = text;
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                        child: Text("저장하기", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: () async {
                          // 여기 inputText 값 가져와서 저장
                          await updateRate(oid, _rating, inputText);
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      )
                  ),
                ],
              ),
            ),
      ]
          ),
        ));
  }

  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _heading(String text) => Column(
    children: [
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}
