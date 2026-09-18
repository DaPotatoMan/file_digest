import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_digest/file_digest.dart';
import 'package:flutter_test/flutter_test.dart';

class Outputs {
  static const md5 = '955d2d86ca13e6af91093a1f978ebd48';
  static const sha256 = 'd62c1633ede5a54eb59627fdde2cb8d4caebc2234a4c09c3aa5cdbe6287c94da';
  static const sha512 =
      'e932cd65577cab144b5d5386b10a6b4211b82cbb9ba28b960837ddec296dbfd3'
      'd9a2c3465be2c6b8c6382d0a938b31792a700b454c9b4e369c7c6170bf88a38e';
}

void main() {
  Future<void> matchDigest(dynamic Function() getFile) async {
    final digest = () {
      final file = getFile();

      return switch (file) {
        XFile() => FileDigest.xFile(file),
        File() => FileDigest.file(file),
        _ => throw UnimplementedError('Unknown file type was provided'),
      };
    }();

    expect(await digest.md5(), Outputs.md5);
    expect(await digest.sha256(), Outputs.sha256);
    expect(await digest.sha512(), Outputs.sha512);
  }

  test('FileDigest.file', () {
    return matchDigest(() => File('test/assets/sample.txt'));
  });

  test('FileDigest.xFile', () async {
    return matchDigest(() => XFile('test/assets/sample.txt'));
  });

  test('FileDigest.bytes can be reused', () async {
    final digest = FileDigest.bytes(Uint8List.fromList('sample'.codeUnits));

    expect(await digest.md5(), '5e8ff9bf55ba3508199d22e984129be6');
    expect(await digest.sha256(), 'af2bdbe1aa9b6ec1e2ade1d694f41fc71a831d0268e9891562113d8a62add1bf');
  });

  test('FileDigest.bytes supports empty data', () async {
    final digest = FileDigest.bytes(Uint8List(0));

    expect(await digest.md5(), 'd41d8cd98f00b204e9800998ecf8427e');
    expect(await digest.sha256(), 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
    expect(
      await digest.sha512(),
      'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce'
      '47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e',
    );
  });
}
