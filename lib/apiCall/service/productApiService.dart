import 'dart:convert';
import 'dart:developer';

import 'package:rider_app_v3/apiCall/constants.dart';
import 'package:rider_app_v3/apiCall/modles/product.dart';
import 'package:http/http.dart' as http;

class ProductApiService {

  Future<List<Product>?> getProducts() async {
    try {
      var url = Uri.parse(ApiConstants.productBaseUrl + ApiConstants.productEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Product> _model = productFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteProduct(int? id) async {
    try {
      var url = Uri.parse(
          ApiConstants.productBaseUrl + ApiConstants.productEndpoint + "/delete/" + '${id}');
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        print("Case deleted");
      } else {
        throw "Failed to delete a case.";
      }
    } catch (e) {
      log(e.toString());
    }
  }



  // Future<Posts?> getCaseById(int id) async {
  //   try{
  //     var url = Uri.parse(
  //         ApiConstants.baseUrl + ApiConstants.postEndpoint + "/" + '${id}');
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       // Posts post = postsFromJson(response.body) as Posts;
  //       Posts post = Posts.fromJson(jsonDecode(response.body));
  //       return post;
  //     } else {
  //       throw Exception('Failed to load a case');
  //     }
  //   }catch(e){
  //     log(e.toString());
  //   }
  // }

  Future<Product?> createProduct(Product product) async {
    // Map data = {
    //   "name": product.name,
    //   "email": product.email,
    //   "price": product.price,
    //   "quantity": product.quantity,
    // };

    var url = Uri.parse(
        ApiConstants.productBaseUrl + ApiConstants.productEndpoint+"/save");

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product));

    if (response.statusCode == 200) {
      Product post = Product.fromJson(jsonDecode(response.body));
      return post;
    } else {
      throw Exception('Failed to load a case');
    }

  }
//
  Future<Product?> updateProduct(Product product) async {
    // Map data = {
    //   "id": product.id,
    //   "name": product.name,
    //   "email": product.email,
    //   "price": product.price,
    //   "quantity": product.quantity,
    // };

    var url = Uri.parse(
        ApiConstants.productBaseUrl + ApiConstants.productEndpoint+"/save");

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product));

    if (response.statusCode == 200) {
      Product post = Product.fromJson(jsonDecode(response.body));
      return post;
    } else {
      throw Exception('Failed to load a case');
    }

  }
}
