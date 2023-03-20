import 'package:flutter/material.dart';
import 'package:rider_app_v3/apiCall/modles/product.dart';
import 'package:rider_app_v3/apiCall/pages/home.dart';

class Edit2 extends StatelessWidget {

  final Product? product;

  Edit2({Key? key, this.product}) : super(key: key);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController quanTextEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    nameTextEditingController.value = TextEditingValue(text: product!.name.toString());
    emailTextEditingController.value = TextEditingValue(text: product!.email.toString());
    ageTextEditingController.value = TextEditingValue(text: product!.price.toString());
    quanTextEditingController.value = TextEditingValue(text: product!.quantity.toString());
  }

  Widget getProduct(context){
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.0,
            ),
            TextField(
              controller: nameTextEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                // hintText: "Email",
                hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 1.0,
            ),
            TextField(
              controller: ageTextEditingController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                // hintText: "Email",
                hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 10.0,
            ),

            TextField(
              controller: emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                // hintText: "Email",
                hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 1.0,
            ),
            TextField(
              controller: quanTextEditingController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                // hintText: "Email",
                hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 10.0,
            ),

            TextButton(
                onPressed: () async {

                  print(product!.name);
                  // (await ProductApiService().deleteProduct(product!.id));
                  // print("Delete Call!");
                  Navigator.pushAndRemoveUntil<dynamic>(context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>Home(),
                    ),
                        (route) =>false,
                  );
                },
                child: Icon(Icons.delete)),
          ],
          // Text(_postsModel![index].body.toString()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (product != null) ? product!.name.toString() : "Product",

        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, "/home", (route) => false);

                Navigator.pushAndRemoveUntil<dynamic>(context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>Home(),
                  ),
                      (route) =>false,
                );
              },
              icon: Icon(Icons.list_alt))
        ],
      ),
      body:product == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :getProduct(context),
    );
  }
}
