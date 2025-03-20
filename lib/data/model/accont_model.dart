import 'package:popcornhub/data/domain/entity/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required super.id,
    required super.username,
    super.name,
    super.avatarPath,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    String? avatarPath;
    if (json['avatar'] != null &&
        json['avatar']['tmdb'] != null &&
        json['avatar']['tmdb']['avatar_path'] != null) {
      avatarPath = json['avatar']['tmdb']['avatar_path'];
    } else {
      avatarPath = null;
    }
    return AccountModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      avatarPath: avatarPath,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'avatar_path': avatarPath,
    }..removeWhere((key, value) => value == null);
  }

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      username: username,
      name: name,
      avatarPath: avatarPath,
    );
  }
}
