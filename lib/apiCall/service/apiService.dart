import 'dart:convert';
import 'dart:developer';

import 'package:rider_app_v3/apiCall/constants.dart';
import 'package:rider_app_v3/apiCall/modles/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:rider_app_v3/apiCall/modles/user_model_2.dart';

class ApiService {
  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Posts>?> getPosts() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Posts> _model = postsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deletePosts(int? id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.postEndpoint + "/" + '${id}');
      var response = await http.delete(url);

      // Response res = await delete('$apiUrl/$id');

      if (response.statusCode == 200) {
        print("Case deleted");
      } else {
        throw "Failed to delete a case.";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Posts?> getCaseById(int id) async {
    try{
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.postEndpoint + "/" + '${id}');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Posts post = postsFromJson(response.body) as Posts;
        Posts post = Posts.fromJson(jsonDecode(response.body));
        return post;
      } else {
        throw Exception('Failed to load a case');
      }
    }catch(e){
      log(e.toString());
    }
  }

  Future<Posts?> createCase(Posts posts) async {
    Map data = {
      "userId": posts.userId,
      "id": posts.id,
      "title": posts.title,
      "body": posts.body,
    };

    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.postEndpoint);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));

    // var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Posts post = postsFromJson(response.body) as Posts;
      Posts post = Posts.fromJson(jsonDecode(response.body));
      return post;
    } else {
      throw Exception('Failed to load a case');
    }

  }
  //
  // Future<Cases> updateCases(String id, Cases cases) async {
  //   Map data = {
  //     'name': cases.name,
  //     'gender': cases.gender,
  //     'age': cases.age,
  //     'address': cases.address,
  //     'city': cases.city,
  //     'country': cases.country,
  //     'status': cases.status
  //   };
  //
  //   final Response response = await put(
  //     '$apiUrl/$id',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return Cases.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update a case');
  //   }
  // }
}
