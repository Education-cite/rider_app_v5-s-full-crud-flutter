import 'package:flutter/material.dart';
import 'package:rider_app_v3/apiCall/modles/product.dart';
import 'package:rider_app_v3/apiCall/pages/home.dart';
import 'package:rider_app_v3/apiCall/service/productApiService.dart';
import 'package:rider_app_v3/crudFirebase/models/task.dart';
import 'package:rider_app_v3/crudFirebase/page/listpage.dart';


class Edit extends StatefulWidget {
  final Product? product;
  Edit({this.product});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<Edit> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController quanTextEditingController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    nameTextEditingController.value = TextEditingValue(text: widget.product!.name.toString());
    emailTextEditingController.value = TextEditingValue(text: widget.product!.email.toString());
    priceTextEditingController.value = TextEditingValue(text: widget.product!.price.toString());
    quanTextEditingController.value = TextEditingValue(text: widget.product!.quantity.toString());
    // nameTextEditingController.value = TextEditingValue(text: widget.product!.name.toString());
    // emailTextEditingController.value = TextEditingValue(text: widget.product!.email.toString());
    // priceTextEditingController.value = TextEditingValue(text: widget.product!.price.toString());
    // quanTextEditingController.value = TextEditingValue(text: widget.product!.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {


    // final DocIDField = TextField(
    //     controller: nameTextEditingController,
    //     readOnly: true,
    //     autofocus: false,
    //     decoration: InputDecoration(
    //         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Name",
    //         border:
    //         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        controller: nameTextEditingController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final emailField = TextFormField(
        controller: emailTextEditingController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final positionField = TextFormField(
        controller: priceTextEditingController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Price",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final contactField = TextFormField(
        controller: quanTextEditingController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Quantity",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {


          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => Home(),
            ),
                (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of Task'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Product _product = new Product();
          _product.id = widget.product!.id;
          _product.name = nameTextEditingController.text;
          _product.email =  emailTextEditingController.text;
          _product.price =  priceTextEditingController.text;
          _product.quantity =  quanTextEditingController.text;

          // print(widget.product!.id);
          (await ProductApiService().updateProduct(_product));
          // viewListbutton;
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => Home(),
            ),
                (route) => false, //if you want to disable back feature set to false
          );
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Product Edit'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // DocIDField,
                    // const SizedBox(height: 25.0),
                    nameField,
                    const SizedBox(height: 25.0),
                    emailField,
                    const SizedBox(height: 25.0),
                    positionField,
                    const SizedBox(height: 35.0),
                    contactField,
                    viewListbutton,
                    const SizedBox(height: 45.0),
                    SaveButon,
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
