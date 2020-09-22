import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController weightController;
  TextEditingController heigthController;
  String _infoText;

  GlobalKey<FormState> _imcFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weightController = TextEditingController();
    heigthController = TextEditingController();
    _infoText = 'Info text';
  }

  void _resetFields() {
    weightController.text = "";
    heigthController.text = "";
  }

  void _calculateIMC() {
    double weight = double.parse(weightController.text);
    double heigth = double.parse(heigthController.text) / 100;
    double imc = weight / (heigth * heigth);
    debugPrint(imc.toString());
    if (imc < 18.6) {
      setState(() {
        _infoText =
            "${weight} is Below the recomended weight with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    } else if (imc >= 18.6 && imc <= 24.9) {
      setState(() {
        _infoText =
            "${weight} is into the recomended weight with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    } else if (imc >= 24.9 && imc <= 29.9) {
      setState(() {
        _infoText =
            "${weight} is slightly above the recomended weight with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    } else if (imc >= 29.9 && imc <= 34.9) {
      setState(() {
        _infoText =
            "${weight} is categorized as Obesity I with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    } else if (imc >= 34.9 && imc <= 39.9) {
      setState(() {
        _infoText =
            "${weight} is categorized as Obesity II with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    } else if (imc >= 40) {
      setState(() {
        _infoText =
            "${weight} is categorized as Obesity III with a IMC of ${imc.toStringAsPrecision(4)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _imcFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 120.0,
              color: Colors.deepPurpleAccent,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25,
                    )),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Input your weight!";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusColor: Colors.deepPurple,
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25,
                    )),
                controller: heigthController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Input your height!";
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: _size.height * 0.013, bottom: _size.height * 0.013),
              height: _size.height * 0.11,
              child: RaisedButton(
                color: Colors.deepPurple,
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                onPressed: () {
                  if (_imcFormKey.currentState.validate()) {
                    _calculateIMC();
                  }
                },
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: _size.height * 0.013, bottom: _size.height * 0.013),
                height: _size.height * 0.11,
                child: Text(
                  _infoText,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    inherit: true,
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
