abstract class FileDigestBase {
  Future<String> md5() => throw UnimplementedError();
  Future<String> sha256() => throw UnimplementedError();
  Future<String> sha512() => throw UnimplementedError();
}
