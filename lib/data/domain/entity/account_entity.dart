class AccountEntity {
  final int id;
  final String username;
  final String? name;
  final String? avatarPath;

  const AccountEntity({
    required this.id,
    required this.username,
    this.name,
    this.avatarPath,
  });
}
