import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<CommentModel?> fromDocument(DocumentSnapshot doc) async {
    final data = doc.data() as Map;
    if (data.isEmpty) return null;

    final authorRef = data['author'] as DocumentReference;
    final authorDoc = await authorRef.get();
    if (authorDoc.exists) {
      return CommentModel(
        postID: data['post_id'],
        content: data['content'],
        date: data['date'].toDate(),
        author: User.fromMap(
          authorDoc.data() as Map<String, dynamic>,
          authorRef.id,
        ),
      );
    }
    return null;
  }

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
