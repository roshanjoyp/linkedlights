import 'package:flutter_test/flutter_test.dart';
import 'package:linked_lights/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LevelDataServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
