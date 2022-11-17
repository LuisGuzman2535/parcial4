import 'package:flutter/material.dart';
import 'package:parcial4/paginas/avion.dart';
import 'package:parcial4/paginas/clientes.dart';
import 'package:parcial4/paginas/colores.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parcial4/paginas/vuelos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightTertiaryColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("PARCIAL 4",
                style: GoogleFonts.gruppo(
                    textStyle: TextStyle(
                        color: AppColor.primaryColor,
                        letterSpacing: 5,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 30,),
            Text("GUZMAN ESCOBAR LUIS ANTONIO 25-3574-2016",
                style: GoogleFonts.gruppo(
                    textStyle: TextStyle(
                        color: AppColor.primaryColor,
                        letterSpacing: 0,
                        fontSize: 10,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 10,),
            Text("ORELLANA MENIVAR OSCAR ARMANDO 25-1735-2016",
                style: GoogleFonts.gruppo(
                    textStyle: TextStyle(
                        color: AppColor.primaryColor,
                        letterSpacing: 0,
                        fontSize: 10,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('CLIENTES', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: AppColor.lightSecondary,
                fixedSize: Size(300, 40),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Clientes()),
                );
              },
            ),SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('AVIONES', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: AppColor.lightSecondary,
                fixedSize: Size(300, 40),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Aviones()),
                );
              },
            ), SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('VUELOS',style: TextStyle(color: Colors.white) ),
              style: ElevatedButton.styleFrom(
                primary: AppColor.lightSecondary,
                fixedSize: Size(300, 40),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vuelos()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}