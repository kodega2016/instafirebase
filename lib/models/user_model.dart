// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? profileImageUrl;
  final int followers;
  final int following;
  final String? bio;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImageUrl,
    this.followers = 0,
    this.following = 0,
    this.bio,
  });

  @override
  List<Object> get props => [id, username, email, profileImageUrl ?? ''];

  static const empty = User(id: '', username: '', email: '');

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImageUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  factory User.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return User(
      id: id,
      username: map['username'] as String,
      email: map['email'] as String,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
      followers: map['followers'] as int,
      following: map['following'] as int,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }
}
