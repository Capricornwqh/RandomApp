import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RandomPasswordPage extends StatefulWidget {
  @override
  _RandomPasswordPageState createState() => _RandomPasswordPageState();
}

class _RandomPasswordPageState extends State<RandomPasswordPage> {
  String _password = '';
  String _length = '12';
  bool _lowercase = true;
  bool _uppercase = true;
  bool _number = true;
  bool _speical = true;

  static const String LowerCase = 'abcdefghijklmnopqistuvwxyz';
  static const String UpperCase = 'ABCDEFGHIJKLMNOPQISTUVWXYZ';
  static const String ArabicNumeral = '01234567890123456789';
  static const String SpeicalCharacter = '!@#%^&*()-+=|[]~<>.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).randomPassword),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _switchLowercase(),
          _switchUppercase(),
          _switchNumber(),
          _switchSpecial(),
          _textLength(),
          _textShow(),
          _buttonGenerate(),
        ],
      ),
    );
  }

  void _generatePassword() {
    int length = int.parse(_length);
    if (length <= 0 || (!_lowercase && !_uppercase && !_number && !_speical)) {
      return;
    }

    List<int> tmpPassword = [];
    List<int> tmpProp = [];
    List<int> propStr = [];

    Random random = Random(DateTime.now().millisecondsSinceEpoch);

    if (_lowercase) {
      propStr.addAll(LowerCase.runes.toList());
    }
    if (_uppercase) {
      propStr.addAll(UpperCase.runes.toList());
    }
    if (_number) {
      propStr.addAll(ArabicNumeral.runes.toList());
    }
    if (_speical) {
      propStr.addAll(SpeicalCharacter.runes.toList());
    }

    while (propStr.length < length * 2) {
      List<int> tmpList = List.from(propStr);
      propStr.addAll(tmpList);
    }

    propStr.shuffle(random);
    for (int i = 0; i < propStr.length; i++) {
      tmpProp.add(i);
    }
    tmpProp.shuffle(random);
    for (int item in tmpProp.getRange(0, length)) {
      tmpPassword.add(propStr[item]);
    }
    setState(() {
      _password = String.fromCharCodes(tmpPassword);
      Clipboard.setData(ClipboardData(text: _password));
    });
  }

  Widget _buttonGenerate() {
    return Container(
      width: 130,
      height: 50,
      child: MaterialButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(
          AppLocalizations.of(context).generate,
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          _generatePassword();
          _snackBar();
        },
      ),
    );
  }

  void _snackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(AppLocalizations.of(context).passwordClipboard,
            textAlign: TextAlign.center),
      ),
    );
  }

  Widget _textShow() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      width: 300,
      height: 120,
      alignment: Alignment.center,
      child: Text(
        _password,
        softWrap: true,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Color(0xFFE6E6E6),
          width: 2,
        ),
      ),
    );
  }

  Widget _textLength() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  AppLocalizations.of(context).length,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: TextField(
                    controller: TextEditingController(text: _length),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter length',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2)
                    ],
                    onChanged: (text) {
                      _length = text;
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _switchLowercase() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Text(
                  AppLocalizations.of(context).lowercaseLetter,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                child: Switch(
                  value: _lowercase,
                  onChanged: (value) {
                    setState(() {
                      _lowercase = value;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _switchUppercase() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Text(
                  AppLocalizations.of(context).uppercaseLetter,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                child: Switch(
                  value: _uppercase,
                  onChanged: (value) {
                    setState(() {
                      _uppercase = value;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _switchNumber() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Text(
                  AppLocalizations.of(context).arabicNumeral,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                child: Switch(
                  value: _number,
                  onChanged: (value) {
                    setState(() {
                      _number = value;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _switchSpecial() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Text(
                  AppLocalizations.of(context).specialCharacter,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                child: Switch(
                  value: _speical,
                  onChanged: (value) {
                    setState(() {
                      _speical = value;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
