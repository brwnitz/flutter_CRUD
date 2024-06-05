import 'package:flutter/material.dart';
import 'package:flutter_treinamento/appbar.dart';
import 'package:flutter_treinamento/dataprovider.dart';
import 'package:flutter_treinamento/edit.dart';
import 'package:flutter_treinamento/product.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

  class MainAppState extends State<MainApp>{
  
  final DataProvider dataProvider = DataProvider();

  void refresh(){
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: const MyAppBar(title: 'Lista de Produtos'),
        body: FutureBuilder<List<Product>>(
          future: dataProvider.getItems(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError){
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Container(
                      margin: const EdgeInsets.only(top:10,bottom: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 14, 31, 46).withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    ),
                    child: ListTile(
                    title: Text(snapshot.data![index].name, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    subtitle: Text(snapshot.data![index].description, style: const TextStyle(color: Colors.white),),
                    trailing: Text('R\$ ${snapshot.data![index].price.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductScreen(product: snapshot.data![index], onProductAdded: refresh),
                        ),
                      );
                      setState(() {
                      });
                    },
                  )
                  )
                  )
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductScreen(product: null, onProductAdded: refresh),
              ),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add,color: Colors.white,),
      ),
    ),backgroundColor: const Color.fromARGB(255, 20, 106, 150),
    )
    );
  }
}