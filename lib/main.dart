import 'package:bloc_example/remote_bloc.dart';
import 'package:bloc_example/remote_event.dart';
import 'package:bloc_example/remote_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text('Âm lượng hiện tại: ${snapshot.data?.volume}');
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(IncrementEvent(5)), // add event <=== new
            child: const Icon(Icons.volume_up),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(DecrementEvent(10)), // add event <=== new
            child: const Icon(Icons.volume_down),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(MuteEvent()), // add event <=== new
            child: const Icon(Icons.volume_mute),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
