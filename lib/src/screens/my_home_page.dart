import 'package:flutter/material.dart';
import 'second_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nameValue;
  String lastnameValue;
  String phoneValue;
  String emailValue;

  // Nodes to make focus on each input
  FocusNode nameFocus;
  FocusNode lastNameFocus;
  FocusNode phoneNumberFocus;
  FocusNode emailFocus;

  // Get access of an element in the tree anymhere
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basics of Navigator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // set its global key
          key: formKey,
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Name:"),
              focusNode: this.nameFocus,
              onSaved: (value) {
                nameValue = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "This field is required";
                }
              },
              onEditingComplete: () => requestFocus(context, lastNameFocus),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "LastName:"),
              focusNode: this.lastNameFocus,
              onSaved: (value) {
                lastnameValue = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "This field is required";
                }
              },
              onEditingComplete: () => requestFocus(context, phoneNumberFocus),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
                decoration: InputDecoration(labelText: "Phone Number:"),
                focusNode: this.phoneNumberFocus,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  phoneValue = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                },
                onEditingComplete: () => requestFocus(context, emailFocus),
                textInputAction: TextInputAction.next),
            TextFormField(
                decoration: InputDecoration(labelText: "Email:"),
                focusNode: this.emailFocus,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  emailValue = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                }),
            RaisedButton(
              child: Text("Send my data"),
              onPressed: () {
                _showSecondPage(context);
              },
            ),
          ]),
        ),
      ),
    );
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();

    // Create the focus nodes
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showSecondPage(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.of(context).pushNamed("/second",
          arguments: SecondPageArguments(
              name: this.nameValue,
              lastName: this.lastnameValue,
              phone: this.phoneValue,
              email: this.emailValue));
    }
  }
}
