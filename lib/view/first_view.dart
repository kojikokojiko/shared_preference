import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPAgeState();
}

class _CounterPAgeState extends State<CounterPage> {
  String _memory = "何か一つしかおぼえられません";


  @override
  void initState() {
    super.initState();
    _getData();
  }

  //保存
  Future<void> _setData(value) async {
    final prefs = await SharedPreferences.getInstance();
    _memory=value;
    setState(() {
      prefs.setString('memory', _memory);
    });
  }

  //読み込み
  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _memory = prefs.getString('memory') ?? "何か一つしかおぼえられません";
    });
  }

  //削除
  Future<void> _removeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('memory');
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_memory',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  _removeData();
                },
                child: Text('削除'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  String temp_memory="何か一つしかおぼえられません";
                  return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText:"覚えたいことを人づだけ",
                          ),
                          onChanged: (value){
                            temp_memory=value;
                          },
                          onFieldSubmitted: (value){
                            temp_memory=value;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _setData(temp_memory);
                            Navigator.pop(context);

                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),

                  );

                }
            );

          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}