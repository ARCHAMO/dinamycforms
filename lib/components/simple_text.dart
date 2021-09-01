import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({Key key}) : super(key: key);
  final url = 'http://localhost:3977/api/prototipos/widgets';

  @override
  _SimpleTextState createState() => _SimpleTextState();
}

class _SimpleTextState extends State<SimpleText> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          var widgetJson = json.decode(snapshot.data.body);
          var widget = JsonWidgetData.fromDynamic(
            widgetJson,
          );
          return widget.build(context: context);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: _getWidget(),
    );
  }

  Future<http.Response> _getWidget() async {
    var uri = Uri.http(widget.url, '');
    return http.get(uri);
  }

  void validateForm() {
    Toast.show('Hola Mundo', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
