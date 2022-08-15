import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseinsta/config/paths.dart';
import 'package:firebaseinsta/models/comment_model.dart';
import 'package:firebaseinsta/models/post_model.dart';
import 'package:firebaseinsta/repositories/posts/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createComment({
    required CommentModel comment,
  }) async {
    await _firestore
        .collection(Paths.comments)
        .doc(comment.id)
        .set(comment.toJson());
  }

  @override
  Future<void> createPost({required PostModel post}) async {
    await _firestore.collection(Paths.posts).doc(post.id).set(post.toJson());
  }

  @override
  Stream<List<CommentModel>> getPostComments({required String postID}) {
    final snapshots = _firestore
        .collection(Paths.comments)
        .doc(postID)
        .collection(Paths.postComments)
        .where('post_id', isEqualTo: postID)
        .orderBy('date', descending: true)
        .snapshots();
    return snapshots.map((event) => event.docs
        .map<CommentModel>((doc) => CommentModel.fromJson(doc.data(), doc.id))
        .toList());
  }

  @override
  Stream<List<PostModel>> getUserPosts({required String userID}) {
    final snapshots = _firestore
        .collection(Paths.posts)
        .where('author', isEqualTo: userID)
        .orderBy('date', descending: true)
        .snapshots();
    return snapshots.map((event) => event.docs
        .map<PostModel>((doc) => PostModel.fromJson(doc.data(), doc.id))
        .toList());
  }
}