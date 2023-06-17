import 'package:flutter/material.dart';
import 'package:project_bab/widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

/* 후기 목록 페이지 */

class CreditPage extends StatefulWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Credit"),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/texture_bab.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // 투명도 조절
                  BlendMode.dstATop, // 블렌드 모드 설정 (필요에 따라 변경 가능)
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                Image.asset(
                  'img/logo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 20,
                ),

                AppText(text: "2023-1학기_캡스톤디자인Ⅰ\n"),
                AppLargeText(text: "Team F5"),
                AppText(text: "이수빈 & 신이진 & 나호영 & 동현석 & 서연호"),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 15,
                ),
                // ----------------------------------------------
                ElevatedButton(
                  child: const Text('github'),
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://github.com/ilsole1025/project_bab',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      print("Can't launch $url");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 0.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
              ],
            )));
  }
}
