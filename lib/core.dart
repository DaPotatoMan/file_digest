import 'dart:typed_data';

abstract class FileDigestBase {
  final Uint8List data;
  const FileDigestBase(this.data);
  FileDigestBase.fromString(String content) : data = Uint8List.fromList(content.codeUnits);

  Future<String> sha256() => throw UnimplementedError();
  Future<String> sha512() => throw UnimplementedError();
}
