import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _reversed = false;
  // 生成唯一 key 值
  List<UniqueKey> _buttonKeys = [UniqueKey(), UniqueKey()];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter(){
    setState(() {
      _counter = 0;
    });
  }
  void _reverseButton(){
    setState(() {
      _reversed = !_reversed;
    });
  }

  void _swap() { setState(() { _reversed = !_reversed; }); }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final incrementButton = FancyButton(
      child: Text( "Increment",
        key: _buttonKeys.first,
        style: TextStyle(color: Colors.white), ),
        onPressed: _incrementCounter,
    );
    final decrementButton = FancyButton(
        // 指定 key
        key: _buttonKeys.last,
        child: Text( "Decrement",
        style: TextStyle(color: Colors.white), ),
        onPressed: _decrementCounter,
    );
    final resetButton = FancyButton(
        child: Text( "Reset",
        style: TextStyle(color: Colors.white), ),
        onPressed: _resetCounter,
    );
    List<Widget> _buttons = <Widget>[incrementButton, decrementButton];
    if (_reversed) { _buttons = _buttons.reversed.toList(); }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 50),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.25),
                borderRadius: BorderRadius.circular(4.0),
              ),
              //child: Image.asset( 'assets/images/flutter_logo_1080.png', width: 100.0, ),
              //child: Image.network("https://flutterchina.club/images/flutter-mark-square-100.png"),
              child: Image.asset( 'assets/images/flutter-mark-square-100.png', width: 100.0, ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buttons[0],
                _buttons[1],
                resetButton,
              ],
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _reverseButton,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This
      // trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class FancyButton extends StatefulWidget{
  final VoidCallback onPressed;
  final Widget child;
  const FancyButton({Key key, this.onPressed,this.child}) : super(key: key);


  @override
  _FancyButtonState createState() => _FancyButtonState();

}
class _FancyButtonState extends State<FancyButton>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: widget.child,
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(_getColors()),
        ),
      ),
    );
  }
  Color _getColors() { return _buttonColors.putIfAbsent(this, () => colors[next(0, 5)]); }
}
Map<_FancyButtonState, Color> _buttonColors = {}; final _random = Random(); int next(int min, int max) => min + _random.nextInt(max - min); List<Color> colors = [ Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.amber, Colors.lightBlue, ];



