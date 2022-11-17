import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcial4/paginas/colores.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();

  final CollectionReference _clientes = FirebaseFirestore.instance.collection('clientes');

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
                        controller: _nombreController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre', hintText: 'Ingrese su Nombre'),
                      ), SizedBox(height: 10),
                      TextField(
                        controller: _apellidoController,
                          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Apellido', hintText: 'Ingrese su Apellido')
                      ),SizedBox(height: 10),
                      TextField(
                        controller: _fechaNacimientoController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Fecha de Nacimiento', hintText: 'DD/MM/YY'),
                      ),SizedBox(height: 10),
                      TextField(
                        controller: _sexoController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Sexo', hintText: 'Ingrese su Sexo'),
                      ),SizedBox(height: 10),
                      TextField(
                        controller: _tipoController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Tipo', hintText: 'Ingrese su tipo de cliente'),
                      ),SizedBox(height: 10),
                      TextField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Usuario', hintText: 'Ingrese su Usuario'),
                      ), SizedBox( height: 10),
                      ElevatedButton(
                        child: const Text('Agregar'),
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.lightSecondary,
                          fixedSize: Size(320, 30),),
                        onPressed: () async {
                            final String nombre = _nombreController.text;
                            final String apellido = _apellidoController.text;
                            final String fechaNacimiento = _fechaNacimientoController.text;
                            final String sexo = _sexoController.text;
                            final String tipo = _tipoController.text;
                            final String usuario = _usuarioController.text;
                            if(nombre != null && usuario != null) {
                                  await _clientes.add({
                                    "nombre": nombre,
                                    "apellido": apellido,
                                    "fechaNacimiento": fechaNacimiento,
                                    "sexo": sexo,
                                    "tipo": tipo,
                                    "usuario": usuario
                                  });
                                  _nombreController.text = '';
                                  _apellidoController.text = '';
                                  _fechaNacimientoController.text = '';
                                  _sexoController.text = '';
                                  _tipoController.text = '';
                                  _usuarioController.text = '';
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
      final TextEditingController _nombreController = TextEditingController();
      final TextEditingController _apellidoController = TextEditingController();
      final TextEditingController _fechaNacimientoController = TextEditingController();
      final TextEditingController _sexoController = TextEditingController();
      final TextEditingController _tipoController = TextEditingController();
      final TextEditingController _usuarioController = TextEditingController();
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
                  controller: _nombreController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre', hintText: 'Ingrese su Nombre'),
                ), SizedBox(height: 10),
                TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Apellido', hintText: 'Ingrese su Apellido')
                ),SizedBox(height: 10),
                TextField(
                  controller: _fechaNacimientoController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Fecha de Nacimiento', hintText: 'DD/MM/YY'),
                ),SizedBox(height: 10),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Sexo', hintText: 'Ingrese su Sexo'),
                ),SizedBox(height: 10),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Tipo', hintText: 'Ingrese su tipo de cliente'),
                ),SizedBox(height: 10),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Usuario', hintText: 'Ingrese su Usuario'),
                ), SizedBox( height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.lightSecondary,
                      fixedSize: Size(320, 30),),
                  child: const Text('Actualizar'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fechaNacimiento = _fechaNacimientoController.text;
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String usuario = _usuarioController.text;
                      if(nombre != null && usuario != null) {
                          await _clientes.doc(documentSnapshot!.id).update({
                            "nombre": nombre,
                            "apellido": apellido,
                            "fechaNacimiento": fechaNacimiento,
                            "sexo": sexo,
                            "tipo": tipo,
                            "usuario": usuario
                          });
                          _nombreController.text = '';
                          _apellidoController.text = '';
                          _fechaNacimientoController.text = '';
                          _sexoController.text = '';
                          _tipoController.text = '';
                          _usuarioController.text = '';
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
    await _clientes.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cliente eliminado exitosamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.lightSecondary,
        title: Text("Clientes"),
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
          stream: _clientes.snapshots(),
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
                          title: Text("Nombre: " + documentSnapshot['nombre'].toString()),
                          subtitle:Text("Usuario: " + documentSnapshot['usuario'].toString()),
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
