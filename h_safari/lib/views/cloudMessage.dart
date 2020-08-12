import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';

CloudFunctionsHelloWorldState pageState;

class CloudFunctionsHelloWorld extends StatefulWidget {
  @override
  CloudFunctionsHelloWorldState createState() {
    pageState = CloudFunctionsHelloWorldState();
    return pageState;
  }
}

class CloudFunctionsHelloWorldState extends State<CloudFunctionsHelloWorld> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final HttpsCallable helloWorld = CloudFunctions.instance
      .getHttpsCallable(functionName: 'helloWorld') // 호출할 Cloud Functions 의 함수명
    ..timeout = const Duration(seconds: 30);  // 타임아웃 설정(옵션)

  String resp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Cloud Functions HelloWorld")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(10),
              color: Colors.deepOrangeAccent,
              child: Text(
                resp,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            // URL로 helloWorld 에 접근
            RaisedButton(
              child: Text("http.get helloWorld"),
              onPressed: () async {
                clearResponse();
                String url =
                    "https://us-central1-flutter-firebase-test-bec76.cloudfunctions.net/helloWorld";
                showProgressSnackBar();
                var response = await http.get(url);
                hideProgressSnackBar();
                setState(() {
                  resp = response.body;
                });
              },
            ),

            // Cloud Functions 으로 호출
            RaisedButton(
              child: Text("Call Cloud Function helloWorld"),
              onPressed: () async {
                try {
                  clearResponse();
                  showProgressSnackBar();
                  final HttpsCallableResult result = await helloWorld.call();
                  setState(() {
                    resp = result.data;
                  });
                } on CloudFunctionsException catch (e) {
                  print('caught firebase functions exception');
                  print('code: ${e.code}');
                  print('message: ${e.message}');
                  print('details: ${e.details}');
                } catch (e) {
                  print('caught generic exception');
                  print(e);
                }
                hideProgressSnackBar();
              },
            )
          ],
        ),
      ),
    );
  }

  clearResponse() {
    setState(() {
      resp = "";
    });
  }

  showProgressSnackBar() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: 10),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("   Calling Firebase Cloud Functions...")
            ],
          ),
        ),
      );
  }

  hideProgressSnackBar() {
    _scaffoldKey.currentState..hideCurrentSnackBar();
  }

  showErrorSnackBar(String msg) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[400],
          duration: Duration(seconds: 10),
          content: Text(msg),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }
}