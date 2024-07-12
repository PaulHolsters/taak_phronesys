import 'package:flutter/material.dart';
import 'package:taak_phronesys/feature/post/page/post_list_page.dart';

void main(){
 // HttpOverrides.global = MyHttpOverrides();
  runApp(const PhronsesysTaak());
}

/*  class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
} */

class PhronsesysTaak extends StatelessWidget {
  const PhronsesysTaak({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: PostListPage()
    );
  }
}
