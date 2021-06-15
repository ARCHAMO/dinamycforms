import 'package:dinamycforms/components/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    if (record.error != null) {
      debugPrint('${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('${record.stackTrace}');
    }
  });

  var registry = JsonWidgetRegistry.instance;

  registry.registerFunctions({
    'validateForm': ({args, registry}) => () {
          BuildContext context = registry.getValue(args[0]);
          var valid = Form.of(context).validate();
          registry.setValue('form_validation', valid);
        },
  });
  registry.setValue('customRect', Rect.largest);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dynamic Json to Widget',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SimpleText(),
    );
  }
}
