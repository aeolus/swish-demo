import 'package:flutter/material.dart';
import 'client.dart';

void main() => runApp(SwishDemoApp());

class SwishDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwishDemo(),
    );
  }
}

class SwishDemoState extends State<SwishDemo> {
  String _paymentRequestToken = 'none';

  Widget futureTokenWidgetOnButtonPress() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      if (_paymentRequestToken != null) {
        return new Text('Payment token: ' + _paymentRequestToken);
      }
      return new Text('no token yet');
    });
  }

  Future<Null> getToken() async {
    String token = await postWithClientCertificate();
    setState(() {
      _paymentRequestToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example App Bar Title'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: const Text('Pay with Swish'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: getToken,
              ),
              futureTokenWidgetOnButtonPress()
            ],
          ),
        ),
      ),
    );
  }
}

class SwishDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwishDemoState();
}
