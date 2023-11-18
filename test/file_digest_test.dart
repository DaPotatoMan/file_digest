import 'dart:typed_data';

import 'package:file_digest/file_digest.dart';
import 'package:flutter_test/flutter_test.dart';

const input = 'MY TEST CONTENT';
const outputs = (
  sha256: 'd62c1633ede5a54eb59627fdde2cb8d4caebc2234a4c09c3aa5cdbe6287c94da',
  sha512:
      'e932cd65577cab144b5d5386b10a6b4211b82cbb9ba28b960837ddec296dbfd3d9a2c3465be2c6b8c6382d0a938b31792a700b454c9b4e369c7c6170bf88a38e',
);

void main() {
  const input = 'MY TEST CONTENT';

  test('FileDigest', () async {
    final data = Uint8List.fromList(input.codeUnits);
    final digest = FileDigest(data);

    expect(await digest.sha256(), outputs.sha256);
    expect(await digest.sha512(), outputs.sha512);
  });

  test('FileDigest.fromString', () async {
    final digest = FileDigest.fromString(input);

    expect(await digest.sha256(), outputs.sha256);
    expect(await digest.sha512(), outputs.sha512);
  });
}
