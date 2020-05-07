import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _infoText = "Informe seus dados";

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  Widget buildTextField(String valor, TextEditingController controller){
    return TextField(
      decoration: InputDecoration(
        labelText: valor,
        labelStyle: TextStyle(
          color: Colors.deepPurple,
          fontSize: 20,
        ),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 25,
      ),
      keyboardType: TextInputType.number,
      controller: controller,
    );
  }

  void calculate() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100;

      double imc = weight / (height * height);
      setState(() {
        if(imc < 17 ) {
          _infoText = "Muito abaixo do peso.\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 17 && imc <= 18.49) {
          _infoText = "Abaixo do peso.\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 18.5 && imc <= 24.99) {
          _infoText = "Peso ideal ou normal.\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 25 && imc <= 29.99) {
          _infoText = "Acima do peso.\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 30 && imc <= 34.99) {
          _infoText = "Obesidade I .\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 35 && imc <= 39.99) {
          _infoText = "Obesidade II (Severa).\nIMC: ${imc.toStringAsPrecision(4)}";
        }else if(imc >= 40) {
          _infoText = "Obesidade III (Mórbida).\nIMC: ${imc.toStringAsPrecision(4)}";
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                setState(() {
                  _heightController.text = "";
                  _weightController.text = "";
                  _infoText = "Informe seus dados";
                });
              },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 170.0,
              color: Colors.deepPurple,
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: buildTextField("Peso(Kg)", _weightController)
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: buildTextField("Altura(cm)", _heightController)
            ),
            Container(
              height: 50,
              child: RaisedButton(
                  child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                  ),
                  color: Colors.deepPurple,
                  onPressed: (){
                    calculate();
                  }
              ),
            ),
            Divider(),
            Text(
              _infoText,
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
