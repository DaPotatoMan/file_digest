import 'dart:typed_data';

import 'package:file_digest/file_digest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getDigest', () async {
    const input = 'MY TEST CONTENT';
    const output = 'd62c1633ede5a54eb59627fdde2cb8d4caebc2234a4c09c3aa5cdbe6287c94da';

    final data = Uint8List.fromList(input.codeUnits);
    final task = FileDigest.getDigest(data);

    expect(await task, output);
  });
}
