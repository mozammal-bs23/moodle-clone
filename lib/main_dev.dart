import 'package:flutter_boilerplate/main.dart' as app;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

void main() {
  FlavorConfig.instance = FlavorConfig.dev();
  app.main();
}
