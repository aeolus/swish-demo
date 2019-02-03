import 'package:flutter/material.dart';
import 'client.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<Null> _getToken() async {
    String token = await postWithClientCertificate();
    setState(() {
      _paymentRequestToken = token;
    });
  }

  _openSwish() async {
    var callbackUrl = 'https://www.google.com';
    var url = 'swish://paymentrequest?token=' + _paymentRequestToken + '&callbackurl=' + callbackUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                child: const Text('Get payment token from Swish'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: _getToken,
              ),
              futureTokenWidgetOnButtonPress(),
              RaisedButton(
                child: const Text('Pay with Swish'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: _openSwish,
              ),
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
