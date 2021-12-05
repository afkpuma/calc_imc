import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 24.9 && imc < 29.9){
      _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obsedidade Grau I (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obsedidade Grau II (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40){
        _infoText = "Obsedidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.white,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
                controller: weightController,

              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira sua altura!";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
                controller: heightController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: SizedBox(
                  height: 80.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        fixedSize: const Size(300,100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),


                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),),
        ),
      );

  }
}
