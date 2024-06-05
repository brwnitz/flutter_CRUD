import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_treinamento/appbar.dart';
import 'package:flutter_treinamento/custom_text_field.dart';
import 'package:flutter_treinamento/dataprovider.dart';
import 'package:flutter_treinamento/main.dart';
import 'package:flutter_treinamento/product.dart';

class EditProductScreen extends StatelessWidget {
  final Product? product;
  final VoidCallback onProductAdded;
  EditProductScreen({super.key, required this.product, required this.onProductAdded});
  final DataProvider dataProvider = DataProvider();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = product?.name ?? '';
    priceController.text = product?.price.toString() ?? '';
    descriptionController.text = product?.description ?? '';


    return Scaffold(
      appBar: const MyAppBar(title: 'Editar Produto'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          CustomTextField(controller: nameController, text: 'Nome do produto', type: TextInputType.text),
          CustomTextField(controller: priceController, text: 'Preço do produto', type: TextInputType.number),
          CustomTextField(controller: descriptionController, text: 'Descrição do produto', type: TextInputType.text),
          ElevatedButton(child: const Text('Salvar'),
          onPressed: 
            () async {
              String name = nameController.text;
              double price = double.parse(priceController.text);
              String description = descriptionController.text;
              if(product?.id != null){
                dataProvider.updatedItem(Product(id: product!.id, name: name, price: price, description: description));
                onProductAdded();
                Navigator.pop(context);
              }
              else{
                await addProduct(dataProvider, name, price, description);
                onProductAdded();
                Navigator.pop(context);
              }
            }
          ),
          if(product?.id != null)
            ElevatedButton(child: const Text('Deletar'),
              onPressed: (){
              dataProvider.deleteItem(product!.id);
              onProductAdded();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainApp()));
          },)
        ],),
      )
      ),
    );
  }

  Future<void> addProduct(DataProvider dataProvider, String name, double price, String description) async{
    List<Product> items = await dataProvider.getItems();
    dataProvider.addItem(
      Product(id: items.length+1, name: name, price: price, description: description),
    );
  }
}