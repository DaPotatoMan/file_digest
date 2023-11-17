import 'package:flutter_test/flutter_test.dart';
import 'package:file_digest/file_digest.dart';
import 'package:file_digest/file_digest_platform_interface.dart';
import 'package:file_digest/file_digest_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFileDigestPlatform
    with MockPlatformInterfaceMixin
    implements FileDigestPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FileDigestPlatform initialPlatform = FileDigestPlatform.instance;

  test('$MethodChannelFileDigest is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFileDigest>());
  });

  test('getPlatformVersion', () async {
    FileDigest fileDigestPlugin = FileDigest();
    MockFileDigestPlatform fakePlatform = MockFileDigestPlatform();
    FileDigestPlatform.instance = fakePlatform;

    expect(await fileDigestPlugin.getPlatformVersion(), '42');
  });
}
