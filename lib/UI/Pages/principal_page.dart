import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:firebase_login/Controller/auth_controller.dart';
import 'package:firebase_login/UI/widgets/alert_dialog.dart';
import 'package:firebase_login/UI/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  String urlLogo =
      'https://firebasestorage.googleapis.com/v0/b/fir-login-a701e.appspot.com/o/acorde.png?alt=media&token=482ddb2f-40d3-4112-bab0-a28c49522b44';
  int selectedTab = 0;

  late CircularBottomNavigationController _navigationController = CircularBottomNavigationController(selectedTab);
  static Color circleColor = Colors.orange;

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, 'Inicio', circleColor),
    TabItem(Icons.article, 'Visión', circleColor),
    TabItem(Icons.perm_identity, 'Quiénes Somos', circleColor),
  ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Acorde', style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        bottomNavigationBar: bottomNavigation(),
        body: bodyPage(),
        drawer: menuDrawer(),
      )
    );
  }

  bodyPage() {
    switch(selectedTab){
      case 0:
        return GestureDetector(
          child:  principalBody(),
          onTap: (){
            if (_navigationController.value == tabItems.length - 1) {
              _navigationController.value = 0;
            } else {
              _navigationController.value = _navigationController.value! + 1;
            }
          },
        );
      case 1:
        return GestureDetector(
          child: const Center(
            child: Text('Visión'),
          ),
          onTap: (){
            if (_navigationController.value == tabItems.length - 1) {
              _navigationController.value = 0;
            } else {
              _navigationController.value = _navigationController.value! + 1;
            }
          },
        );
      case 2:
        return GestureDetector(
          child: const Center(
            child: Text('Quiénes Somos'),
          ),
          onTap: (){
            if (_navigationController.value == tabItems.length - 1) {
              _navigationController.value = 0;
            } else {
              _navigationController.value = _navigationController.value! + 1;
            }
          },
        );
    }
  }

  bottomNavigation() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedTab,
      animationDuration: const Duration(milliseconds: 350),
      selectedCallback: (int? selectedTab){
        setState((){
          this.selectedTab = selectedTab ?? 0;
        });
      },
    );
  }

  principalBody() {
    return const Center(
        child: Text('Página principal')
    );
  }

  menuDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0)
              ),
              child: Image(
                image: NetworkImage(urlLogo),
              ),
            ),
          ),
          const Center(
              child: Text('Café Acorde',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                      fontSize: 20
                  )
              )
          ),
          const SizedBox(height: 3,),
          ListTile(
            iconColor: Colors.brown,
            title: const Text('Cambiar Contraseña', style: TextStyle(fontSize: 15)),
            leading: const Icon(Icons.password_outlined),
            textColor: Colors.brown,
            onTap: (){},
          ),
          const SizedBox(height: 3,),
          ListTile(
            iconColor: Colors.brown,
            title: const Text('Cerrar Sesión', style: TextStyle(fontSize: 15)),
            leading: const Icon(Icons.logout_outlined),
            textColor: Colors.brown,
            onTap: (){
              AuthController.singOut(context).then((value) {
                //loadingDialog(context, false);
                alertDialog('Se ha cerrado la sesión',context);
              });
            },
          ),
          const SizedBox(height: 3,),
        ],
      ),
    );
  }
}
