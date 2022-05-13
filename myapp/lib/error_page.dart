import 'package:flutter/material.dart';
import 'package:myapp/widgets.dart';


class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'ERROR PAGE'),
      drawer: ArgonDrawer(),
      body: Center(
        child: Text('Error page'),
      ),
    );
  }
}
