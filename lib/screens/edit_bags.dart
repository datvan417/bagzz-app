import 'package:bagzz/models/list_bag.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/bag.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _form = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  var _intState = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'price': 0,
    'description': '',
    'imageUrl': '',
    'attribute': '',
    'material': '',
    'paymentsOptions': '',
    'policy': '',
    'shippingInfo': '',
    'style': '',
  };
  var _editedBag = Bag(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    attribute: '',
    material: '',
    paymentsOptions: '',
    policy: '',
    shippingInfo: '',
    style: '',
    isFavorite: false,
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_intState) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final bagId = ModalRoute.of(context)!.settings.arguments as String;
        _editedBag =
            Provider.of<ListBagProvider>(context, listen: false).findBag(bagId);

        _initValues = {
          'title': _editedBag.title,
          'price': _editedBag.price.toString(),
          'description': _editedBag.description,
          'imageUrl': _editedBag.imageUrl,
          'attribute': _editedBag.attribute,
          'material': _editedBag.material,
          'paymentsOptions': _editedBag.paymentsOptions,
          'policy': _editedBag.policy,
          'shippingInfo': _editedBag.shippingInfo,
          'style': _editedBag.style,
        };
        _imageUrlController.text = _editedBag.imageUrl;
      }
    }
    _intState = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  //update Image khi ta khong con trong input Image Url
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedBag.id != '') {
      await Provider.of<ListBagProvider>(context, listen: false)
          .updateBag(_editedBag.id, _editedBag);
    } else {
      try {
        await Provider.of<ListBagProvider>(context, listen: false)
            .addBag(_editedBag);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred'),
            content: const Text('Something went wrong'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        centerTitle: true,
        elevation: 0.7,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Bag',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () => _saveForm(),
            icon: const Icon(
              Icons.save,
              size: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const SpinKitSpinningLines(color: Colors.black)
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 25.0, right: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                margin:
                                    const EdgeInsets.only(top: 8, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: _imageUrlController.text.isEmpty
                                    ? Center(
                                        child: IconButton(
                                          icon: const Icon(Icons.camera_alt),
                                          onPressed: () {
                                            FocusScope.of(context).requestFocus(
                                                _imageUrlFocusNode);
                                          },
                                        ),
                                      )
                                    : FittedBox(
                                        child: (!_imageUrlController.text
                                                    .startsWith('http') &&
                                                !_imageUrlController.text
                                                    .startsWith('https'))
                                            ? Image.asset(
                                                _imageUrlController.text,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                _imageUrlController.text,
                                                fit: BoxFit.cover,
                                              )),
                              ),
                              const SizedBox(height: 25.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Image URL',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an image URL.';
                                  }

                                  if (!value.endsWith('.png') &&
                                      !value.endsWith('.jpg') &&
                                      !value.endsWith('.jpeg')) {
                                    return 'Please enter a valid image URL.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedBag = Bag(
                                    id: _editedBag.id,
                                    title: _editedBag.title,
                                    attribute: _editedBag.attribute,
                                    style: _editedBag.style,
                                    price: _editedBag.price,
                                    description: _editedBag.description,
                                    shippingInfo: _editedBag.shippingInfo,
                                    paymentsOptions: _editedBag.paymentsOptions,
                                    imageUrl: value as String,
                                    material: _editedBag.material,
                                    policy: _editedBag.policy,
                                    isFavorite: _editedBag.isFavorite,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['title'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Title', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: value as String,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['price'].toString(),
                        decoration: const InputDecoration(
                            labelText: 'Price', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: double.parse(value!),
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['style'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Style', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: value as String,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['description'] as String,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: value as String,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['attribute'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Attribute',
                            border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: value as String,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['material'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Material',
                            border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: value as String,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['paymentsOptions'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Payments Options',
                            border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: value as String,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['policy'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Policy', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: _editedBag.shippingInfo,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: value as String,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: _initValues['shippingInfo'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Shipping Info',
                            border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedBag = Bag(
                            id: _editedBag.id,
                            title: _editedBag.title,
                            attribute: _editedBag.attribute,
                            style: _editedBag.style,
                            price: _editedBag.price,
                            description: _editedBag.description,
                            shippingInfo: value as String,
                            paymentsOptions: _editedBag.paymentsOptions,
                            imageUrl: _editedBag.imageUrl,
                            material: _editedBag.material,
                            policy: _editedBag.policy,
                            isFavorite: _editedBag.isFavorite,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
