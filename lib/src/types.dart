/// A function that opens a stream of file bytes.
typedef FileStreamReader = Stream<List<int>> Function();

/// Supported digest algorithms.
enum DigestType {
  /// MD5 algorithm.
  md5('MD5'),

  /// SHA-256 algorithm.
  sha256('SHA-256'),

  /// SHA-512 algorithm.
  sha512('SHA-512');

  /// Creates a digest type with its display [label].
  const DigestType(this.label);

  /// The display name of this digest type.
  final String label;
}
