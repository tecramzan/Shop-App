import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/product.dart';
import 'package:shop_app/Provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-screen';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _form = GlobalKey<FormState>();
  var editProductS = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateimageUrl);
    super.initState();
  }

  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null && productId.isNotEmpty && productId.isNotEmpty) {
        editProductS = Provider.of<Products>(context).findbyId(productId);
        _initValues = {
          'title': editProductS.title,
          'description': editProductS.description,
          'price': editProductS.price.toString(),
          'imageUrl': '',
        };
        _imageUrlControler.text = editProductS.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateimageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  void _updateimageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlControler.text.startsWith('http') &&
              !_imageUrlControler.text.startsWith('https')) ||
          (!_imageUrlControler.text.endsWith('png') &&
              !_imageUrlControler.text.endsWith('jpg') &&
              !_imageUrlControler.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (editProductS.id!.isEmpty) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(editProductS.id!, editProductS);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(editProductS);
    }

    Navigator.of(context).pop();
    // print(editProductS.title);
    // print(editProductS.price);
    // print(editProductS.description);
    // print(editProductS.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    print(_imageUrlControler.text);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              initialValue: _initValues['title'],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title.';
                }
              },
              onSaved: (value) {
                editProductS = Product(
                    id: editProductS.id,
                    isFavorite: editProductS.isFavorite,
                    title: value!,
                    description: editProductS.description,
                    price: editProductS.price,
                    imageUrl: editProductS.imageUrl);
              },
              decoration: InputDecoration(labelText: 'Title:'),
            ),
            TextFormField(
              initialValue: _initValues['price'],
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter price.';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number.';
                }
                if (double.parse(value) <= 0) {
                  return 'Please enter a number greater than zero';
                }
              },
              onSaved: (value) {
                editProductS = Product(
                    id: editProductS.id,
                    isFavorite: editProductS.isFavorite,
                    title: editProductS.title,
                    description: editProductS.description,
                    price: double.parse(value.toString()),
                    imageUrl: editProductS.imageUrl);
              },
              decoration: InputDecoration(labelText: 'Price:'),
            ),
            TextFormField(
              initialValue: _initValues['description'],
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onSaved: (value) {
                editProductS = Product(
                    id: editProductS.id,
                    isFavorite: editProductS.isFavorite,
                    title: editProductS.title,
                    description: value!,
                    price: editProductS.price,
                    imageUrl: editProductS.imageUrl);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter description.';
                }
                if (value.length < 10) {
                  return 'Should be at least 10 character long.';
                }
              },
              decoration: InputDecoration(labelText: 'Description:'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 10),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlControler.text.isEmpty
                        ? Center(
                            child: Text('Enter Url'),
                          )
                        : FittedBox(
                            child: Image.network(
                            _imageUrlControler.text,
                            fit: BoxFit.cover,
                          )),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    // initialValue: _initValues['imageUrl'],
                    keyboardType: TextInputType.url,
                    controller: _imageUrlControler,
                    focusNode: _imageUrlFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Url.';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Please enter a valid Url.';
                      }
                      if (!value.endsWith('png') &&
                          !value.endsWith('jpg') &&
                          !value.endsWith('jpeg')) {
                        return 'Please enter a valid image Url.';
                      }
                    },
                    onSaved: (value) {
                      editProductS = Product(
                          id: editProductS.id,
                          isFavorite: editProductS.isFavorite,
                          title: editProductS.title,
                          description: editProductS.description,
                          price: editProductS.price,
                          imageUrl: value!);
                    },
                    decoration: InputDecoration(labelText: 'Image URL'),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
