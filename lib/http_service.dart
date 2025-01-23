import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  final String _postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(_postsURL));

      if (response.statusCode == 200) {
        List<Post> posts = (jsonDecode(response.body) as List)
            .map((item) => Post.fromJson(item))
            .toList();
        return posts;
      } else {
        throw Exception("Gagal mengambil postingan. Status code: ${response.statusCode}");
      }
    } on http.ClientException catch (e) {
      throw Exception("Kesalahan jaringan: $e");
    } catch (e) {
      throw Exception("Kesalahan tidak terduga: $e");
    }
  }
}