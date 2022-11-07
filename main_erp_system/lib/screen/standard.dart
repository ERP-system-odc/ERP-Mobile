import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/screen/user_model.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'package:http/http.dart' as http;

class Standex extends StatefulWidget {
  const Standex({Key? key}) : super(key: key);

  @override
  _StandexState createState() => _StandexState();
}

class _StandexState extends State<Standex> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  // ignore: unnecessary_new
  late UserModel userModel = new UserModel(
    "",
    List<String>.empty(growable: true),
    new List<String>.empty(growable: true),
    // List<String>.empty(growable: true),
  );

  @override
  void initState() {
    super.initState();
    userModel.userAge.add("");
    userModel.emails.add("");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleText("please_add_your_standard_here"),
          backgroundColor: Color(0xFF5048E5),
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 20),
            tabs: [
              Container(
                height: 35,
                child: const Text('add'),
              ),
              Container(
                height: 35,
                child: const Text('view'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _uiWidget(),
                  ],
                ),
              ),
            ),
            const Center(
              child: Text('Under construction for table view'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uiWidget() {
    return new Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //////
              //////
              //////
              ////// for name
              //////
              //////
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  //Icon(Icons.web),
                  "name",
                  "Standard Name",
                  "",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Standard Name can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    this.userModel.userName = onSavedVal,
                  },
                  initialValue: this.userModel.userName,
                  obscureText: false,
                  labelBold: true,
                  borderFocusColor: Color(0xFF5048E5),
                  prefixIconColor: Color(0xFF5048E5),
                  borderColor: Color(0xFF5048E5),
                  enabledBorderWidth: 2,
                  hintColor: Color(0xFF5048E5),
                  textColor: Color(0xFF5048E5),

                  borderRadius: 3,
                  paddingLeft: 0,
                  paddingRight: 0,
                  showPrefixIcon: false,
                  fontSize: 15,
                  labelFontSize: 15,
                  onChange: (val) {},
                ),
              ),
              //////
              //////
              //////
              ////// for age
              //////
              //////
              SizedBox(
                height: 25,
              ),
              //////
              //////
              //////
              ////// for inventory email
              //////
              //////
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Text(
                        "Inventory Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    emailsContainerUI(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Text(
                        "Inventory Quantity",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    quntityContainerUI(),
                    new Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Color(0xFF42A5F5),
                            gradient: LinearGradient(colors: [
                              hexStringToColor('5048E5'),
                              hexStringToColor("5048E5"),
                            ]),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (validateAndSave()) {
                                print(this.userModel.toJson());
                                final prefsTr =
                                    await SharedPreferences.getInstance();
                                final tokenn = prefsTr.getString('token');
                                print("_------------------");
                                print(tokenn);
                                try {
                                  var response = await http.post(
                                      Uri.parse(
                                          'http://localhost:5000/api/standard/manage'),
                                      headers: {
                                        HttpHeaders.contentTypeHeader:
                                            'application/json',
                                        'Content-Type': 'application/json',
                                        'Accept': 'application/json',
                                        'Authorization': 'Bearer $tokenn',
                                      },
                                      body: userModel);
                                  try {
                                    if (response.statusCode == 200) {
                                      print('you added your standard');
                                    } else {
                                      print('you added inventory');
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }
                              }
                            },
                            child: const LocaleText(
                              "Submit",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // child: FormHelper.submitButton(
                      //   "Submit",
                      //   () async {
                      //     if (validateAndSave()) {
                      //       print(this.userModel.toJson());
                      //     }
                      //   },
                      // ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////
  //////
  //////
  ////// for email
  //////
  //////

  Widget emailsContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: this.userModel.emails.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: emailUI(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget emailUI(index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FormHelper.inputFieldWidget(
              context,
              // Icon(Icons.web),
              "email_$index",
              " Enter Inventory",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'inventory name ${index + 1} can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                this.userModel.emails[index] = onSavedVal,
              },
              initialValue: this.userModel.emails[index],
              obscureText: false,
              borderFocusColor: Color(0xFF5048E5),
              prefixIconColor: Color(0xFF5048E5),
              borderColor: Color(0xFF5048E5),
              enabledBorderWidth: 2,
              textColor: Color(0xFF5048E5),
              hintColor: Color(0xFF5048E5),
              borderRadius: 2,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: false,
              fontSize: 15,
              onChange: (val) {},
            ),
          ),
          // Visibility(
          //   child: SizedBox(
          //     width: 35,
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.add_circle,
          //         color: Colors.green,
          //       ),
          //       onPressed: () {
          //         addEmailControl();
          //       },
          //     ),
          //   ),
          //   visible: index == this.userModel.emails.length - 1,
          // ),
          // Visibility(
          //   child: SizedBox(
          //     width: 35,
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.remove_circle,
          //         color: Colors.redAccent,
          //       ),
          //       onPressed: () {
          //         removeEmailControl(index);
          //       },
          //     ),
          //   ),
          //   visible: index > 0,
          // )
        ],
      ),
    );
  }

  //////
  //////
  //////
  ////// for quantity
  //////
  //////

  Widget quntityContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: this.userModel.userAge.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: quntityUI(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget quntityUI(index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FormHelper.inputFieldWidget(
              context,
              // Icon(Icons.web),
              "quantity_$index",
              " Enter Quantity",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Quantity ${index + 1} can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                this.userModel.userAge[index] = onSavedVal,
              },
              initialValue: this.userModel.userAge[index],
              obscureText: false,
              borderFocusColor: Color(0xFF5048E5),
              prefixIconColor: Color(0xFF5048E5),
              borderColor: Color(0xFF5048E5),
              enabledBorderWidth: 2,
              borderRadius: 2,
              textColor: Color(0xFF5048E5),
              hintColor: Color(0xFF5048E5),
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: false,
              fontSize: 15,
              onChange: (val) {},
            ),
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addEmailControl();
                },
              ),
            ),
            visible: index == this.userModel.userAge.length - 1,
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeEmailControl(index);
                },
              ),
            ),
            visible: index > 0,
          )
        ],
      ),
    );
  }

  void addEmailControl() {
    setState(() {
      this.userModel.emails.add("");
      this.userModel.userAge.add("");
    });
  }

  void removeEmailControl(index) {
    setState(() {
      if (this.userModel.emails.length > 1) {
        this.userModel.emails.removeAt(index);
        this.userModel.userAge.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
