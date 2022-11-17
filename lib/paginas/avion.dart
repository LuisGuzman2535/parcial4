import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcial4/paginas/colores.dart';

class Aviones extends StatefulWidget {
  const Aviones({super.key});

  @override
  State<Aviones> createState() => _AvionesState();
}

class _AvionesState extends State<Aviones> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  final CollectionReference _avion = FirebaseFirestore.instance.collection('avion');

  Future<void> _agregar([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _marcaController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Marca', hintText: 'Ingrese la marca'),
                ), SizedBox(height: 10),
                TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Estado', hintText: 'Ingrese el estado')
                ),SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.lightSecondary,
                    fixedSize: Size(320, 30),),
                  onPressed: () async {
                    final String marca = _marcaController.text;
                    final String estado = _estadoController.text;

                    if(marca != null && estado != null) {
                      await _avion.add({
                        "marca": marca,
                        "estado": estado,
                      });
                      _marcaController.text = '';
                      _estadoController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
  Future<void> _actualizar([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      final TextEditingController _marcaController = TextEditingController();
      final TextEditingController _estadoController = TextEditingController();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _marcaController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Marca', hintText: 'Ingrese la marca'),
                ), SizedBox(height: 10),
                TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Estado', hintText: 'Ingrese el estado')
                ),SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.lightSecondary,
                      fixedSize: Size(320, 30),),
                    child: const Text('Actualizar'),
                    onPressed: () async {
                      final String marca = _marcaController.text;
                      final String estado = _estadoController.text;

                      if(marca != null && estado != null) {
                        await _avion.doc(documentSnapshot!.id).update({
                          "marca": marca,
                          "estado": estado,
                        });
                        _marcaController.text = '';
                        _estadoController.text = '';
                        Navigator.of(context).pop();
                      }
                    }
                )
              ],
            ),
          );
        });
  }
  Future<void> _borrar(String productId) async {
    await _avion.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Avion eliminado exitosamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.lightSecondary,
        title: Text("Aviones"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => _agregar(),
              child: Text("Agregar", style: TextStyle(fontWeight: FontWeight.w800),),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: _avion.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if(streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    return Padding(

                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColor.primaryColor,
                              child: Icon(Icons.airplanemode_active, color: AppColor.lightSecondary,),
                            ),
                            title: Text("Marca: " + documentSnapshot['marca'].toString()),
                            subtitle:Text("Estado: " + documentSnapshot['estado'].toString()),
                            trailing:  SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.edit_note, color: AppColor.lightSecondary, size: 26.0),
                                      onPressed: () => _actualizar(documentSnapshot)),
                                  IconButton(
                                      icon: const Icon(Icons.clear, color: AppColor.lightSecondary, size: 26.0),
                                      onPressed: () => _borrar(documentSnapshot.id)),
                                ],
                              ),
                            ),
                          ),
                        )
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
