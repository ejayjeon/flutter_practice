enum TokenType {
  accessToken(
    key: "ACCESS_TOKEN_KEY",
    title: "accessToken",
  ),
  refreshToken(
    key: "REFRESH_TOKEN_KEY",
    title: "refreshToken",
  );

  final String key;
  final String title;

  const TokenType({
    required this.key,
    required this.title,
  });
}
