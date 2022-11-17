import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parcial4/paginas/colores.dart';

class Vuelos extends StatefulWidget {
  const Vuelos({super.key});

  @override
  State<Vuelos> createState() => _VuelosState();
}

class _VuelosState extends State<Vuelos> {
  final TextEditingController _disponibilidadController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _avionController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  final CollectionReference _vuelos = FirebaseFirestore.instance.collection('vuelos');

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
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _disponibilidadController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Disponibilidad', hintText: 'Numero de asientos disponibles'),
                ), SizedBox(height: 10),
                TextField(
                    controller: _destinoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Destino', hintText: 'Ingrese el destino')
                ),SizedBox(height: 10),
                TextField(
                    controller: _avionController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Avion', hintText: 'Ingrese el avion')
                ),SizedBox(height: 10),
                TextField(
                    controller: _tipoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Tipo', hintText: 'Ingrese el tipo')
                ),SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.lightSecondary,
                    fixedSize: Size(320, 30),),
                  onPressed: () async {
                    final double? disponibilidad =
                    double.tryParse(_disponibilidadController.text);
                    final String destino = _destinoController.text;
                    final String avion = _avionController.text;
                    final String tipo = _tipoController.text;
                    if(disponibilidad != null) {
                      await _vuelos.add({
                        "disponibilidad": disponibilidad,
                        "destino": destino,
                        "avion": avion,
                        "tipo": tipo,
                      });

                      _disponibilidadController.text = '';
                      _destinoController.text = '';
                      _avionController.text = '';
                      _tipoController.text = '';
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
      final TextEditingController _disponibilidadController = TextEditingController();
      final TextEditingController _destinoController = TextEditingController();
      final TextEditingController _avionController = TextEditingController();
      final TextEditingController _tipoController = TextEditingController();
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
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _disponibilidadController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Disponibilidad', hintText: 'Numero de asientos disponibles'),
                ), SizedBox(height: 10),
                TextField(
                    controller: _destinoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Destino', hintText: 'Ingrese el destino')
                ),SizedBox(height: 10),
                TextField(
                    controller: _avionController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Avion', hintText: 'Ingrese el avion')
                ),SizedBox(height: 10),
                TextField(
                    controller: _tipoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Tipo', hintText: 'Ingrese el tipo')
                ),SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.lightSecondary,
                      fixedSize: Size(320, 30),),
                    child: const Text('Actualizar'),
                    onPressed: () async {
                      final double? disponibilidad =
                      double.tryParse(_disponibilidadController.text);
                      final String destino = _destinoController.text;
                      final String avion = _avionController.text;
                      final String tipo = _tipoController.text;

                      if(disponibilidad != null) {
                        await _vuelos.doc(documentSnapshot!.id).update({
                          "disponibilidad": disponibilidad,
                          "destino": destino,
                          "avion": avion,
                          "tipo": tipo,
                        });
                        _disponibilidadController.text = '';
                        _destinoController.text = '';
                        _avionController.text = '';
                        _tipoController.text = '';
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
    await _vuelos.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Avion eliminado exitosamente')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.lightSecondary,
        title: Text("Vuelos"),
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
          stream: _vuelos.snapshots(),
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
                              child: Icon(Icons.beach_access, color: AppColor.lightSecondary,),
                            ),
                            title: Text("Destino: " + documentSnapshot['destino'].toString()),
                            subtitle:Text("Disponibilidad: " + documentSnapshot['disponibilidad'].toString()),
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
