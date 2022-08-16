import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/config/paths.dart';
import 'package:firebaseinsta/models/user_model.dart';

class PostModel extends Equatable {
  final String? id;
  final String caption;
  final String? imageUrl;
  final DateTime date;
  final int likes;
  final User user;

  const PostModel({
    this.id,
    required this.caption,
    required this.user,
    required this.date,
    this.imageUrl,
    this.likes = 0,
  });

  @override
  List<Object?> get props => [id, caption, user, date, likes];

  static Future<PostModel?> fromDocument(DocumentSnapshot doc) async {
    final data = doc.data() as Map;
    if (data.isEmpty) return null;

    final authorRef = data['author'] as DocumentReference;
    final authorDoc = await authorRef.get();
    if (authorDoc.exists) {
      return PostModel(
        id: doc.id,
        caption: doc['caption'],
        user: User.fromMap(
            authorDoc.data() as Map<String, dynamic>, authorDoc.id),
        date: doc['date'].toDate(),
        imageUrl: doc['imageUrl'],
        likes: doc['likes'],
      );
    }
    return null;
  }

  factory PostModel.fromJson(Map<String, dynamic> json, String id) {
    return PostModel(
      id: id,
      caption: json['caption'],
      user: json['user'],
      date: json['date'].toDate(),
      imageUrl: json['imageUrl'],
      likes: json['likes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(user.id).path,
      'imageUrl': imageUrl,
      'caption': caption,
      'date': Timestamp.fromDate(date),
      'likes': likes,
    };
  }
}
