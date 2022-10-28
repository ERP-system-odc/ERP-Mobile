import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:main_erp_system/dashboard/navigation.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:main_erp_system/utils/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'am']);
  runApp(const dashboard());
}

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  //final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return LocaleBuilder(
            builder: (Locale) => MaterialApp(
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: Locale,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: buildMaterialColor(Color(0xFF5048E5)),
              ),
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              home: MyHomePage(),
            ),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //const CategoriesScroller();
  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavBar(),
      appBar: AppBar(
        title: LocaleText('dashboard'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.language),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("🇺🇸  English"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("🇪🇹  አማርኛ"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                LocaleNotifier.of(context)?.change('en');
              } else if (value == 1) {
                LocaleNotifier.of(context)?.change('am');
              } else if (value == 2) {
                print("under construction");
              } else if (value == 3) {
                print("under construction");
              }
            },
          ),
          IconButton(
              icon: Icon(_dashboardState.themeNotifier.value == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                _dashboardState.themeNotifier.value =
                    _dashboardState.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              //physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: FittedBox(
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(right: 20),
                        height: categoryHeight,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 6,
                                blurRadius: 7,
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    child: LocaleText(
                                      "capital",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 22,
                                    child: Icon(
                                      Icons.account_balance,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                " \$5K",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '    15%',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(right: 20),
                        height: categoryHeight,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 6,
                                blurRadius: 7,
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  LocaleText(
                                    "total_profit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 22,
                                    child: Icon(
                                      Icons.money_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " \$21K",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                '    30%',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(right: 20),
                        height: categoryHeight,
                        decoration: BoxDecoration(
                            color: Color(0xFF2196F3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 6,
                                blurRadius: 7,
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  LocaleText(
                                    "total_progress",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22,
                                    child: Icon(
                                      Icons.money_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " \$51K",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Text(
                                '    49%',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(right: 20),
                        height: categoryHeight,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 6,
                                blurRadius: 7,
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  LocaleText(
                                    "total_expense",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 22,
                                    child: Icon(
                                      Icons.money_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " \$17K",
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Text(
                                '    29%',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //fo pie chart
            Container(
              child: piechart(),
              //child: Text('most wanted pie chart'),
            )
          ],
        ),
      ),
    );
  }
}
