import 'package:firebaseinsta/models/comment_model.dart';
import 'package:firebaseinsta/models/post_model.dart';

abstract class BasePostRepository {
  Future<void> createPost({required PostModel post});
  Future<void> createComment({required CommentModel comment});
  Stream<List<PostModel>> getUserPosts({required String userID});
  Stream<List<CommentModel>> getPostComments({required String postID});
}
