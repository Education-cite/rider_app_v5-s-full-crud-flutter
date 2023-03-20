import 'package:flutter/material.dart';
import 'package:rider_app_v3/apiCall/modles/product.dart';
import 'package:rider_app_v3/apiCall/modles/user_model.dart';
import 'package:rider_app_v3/apiCall/modles/user_model_2.dart';
import 'package:rider_app_v3/apiCall/pages/create.dart';
import 'package:rider_app_v3/apiCall/pages/detail.dart';
import 'package:rider_app_v3/apiCall/service/apiService.dart';
import 'package:rider_app_v3/apiCall/service/productApiService.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<UserModel>? _userModel = [];
  late List<Posts>? _postsModel = [];
  late List<Product>? _productModel = [];

  void _getData() async {
    // _userModel = (await ApiService().getUsers())!;
    // _postsModel = (await ApiService().getPosts())!;
    _productModel = (await ProductApiService().getProducts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget _getProductList(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example for Post'),
        actions: [
          IconButton(
              onPressed: () {
                // goBack(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => FormApp(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(Icons.create))
        ],
      ),
      body: _productModel == null || _productModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemCount: _productModel!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(_productModel![index].name.toString()),
                    subtitle: Text(_productModel![index].email.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                Detail(product: _productModel![index]),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
    );
  }

  Widget _getPostList(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example for Post'),
        actions: [
          IconButton(
              onPressed: () {
                // goBack(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp))
        ],
      ),
      body: _postsModel == null || _postsModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemCount: _postsModel!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(_postsModel![index].title.toString()),
                    subtitle: Text(_postsModel![index].body.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                Detail(posts: _postsModel![index]),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
    );
  }

  Widget _getUserList(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
        actions: [
          IconButton(
              onPressed: () {
                // goBack(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp))
        ],
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _userModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(_userModel![index].id.toString()),
                          Text(_userModel![index].username),
                          Text(_userModel![index].email),
                          Text(_userModel![index].website),
                          TextButton(
                            onPressed: () {
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, "/detail", (route) => false);

                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      Detail(userModel: _userModel![index]),
                                ),
                                (route) => false,
                              );
                            },
                            child: Icon(Icons.insert_invitation_outlined,
                                size: 20),
                            style:
                                ButtonStyle(alignment: Alignment.centerRight),
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20.0,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(_userModel![index].email),
                      //     Text(_userModel![index].website),
                      //   ],
                      // ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getProductList(context);
  }
}

// goBack(BuildContext context){
//   Navigator.pop(context);
// }
