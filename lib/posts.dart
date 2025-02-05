import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'post_detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService _httpService = HttpService();

  PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: FutureBuilder(
        future: _httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return _buildPostList(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPostList(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text("User ID: ${post.userId}"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetail(post: post),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(
        "Error: $error",
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}