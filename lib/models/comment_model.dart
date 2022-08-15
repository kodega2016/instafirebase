import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/models/user_model.dart';

class CommentModel extends Equatable {
  final String? id;
  final String postID;
  final String content;
  final DateTime date;
  final User author;

  const CommentModel({
    this.id,
    required this.postID,
    required this.content,
    required this.date,
    required this.author,
  });

  @override
  List<Object?> get props => [id, postID, content, date, author];

  factory CommentModel.fromJson(Map<String, dynamic> json, String id) {
    return CommentModel(
      postID: json['post_id'],
      content: json['content'],
      date: json['date'].toDate(),
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
