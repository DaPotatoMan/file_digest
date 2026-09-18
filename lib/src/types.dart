typedef FileStreamReader = Stream<List<int>> Function();

enum DigestType {
  md5('MD5'),
  sha256('SHA-256'),
  sha512('SHA-512');

  const DigestType(this.label);
  final String label;
}
