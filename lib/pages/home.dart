import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///D:/Apps/worldtime/lib/weather/weather.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data ={};


  @override

  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgimage = data['isDaytime'] ? 'day.jpg' : 'night2.jpg';
    Color bgColor = data['isDaytime'] ? Colors.amber[900] : Colors.teal[900];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  data['isDaytime'] ? Colors.amber[900] : Colors.teal[900],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex:1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child:DrawerHeader(
              decoration: BoxDecoration(
                  color: data['isDaytime'] ? Colors.amber[900] : Colors.teal[900],
              ),
                child: Text(
                    "Menu",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: data['isDaytime'] ? Colors.black : Colors.grey,
                    fontSize: 20.0,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        Expanded(
            flex:2,
            child: ListTile(
                title: Text("Weather"),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => weather()));
                },
             ),
            )
          ]
        ),
       ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/$bgimage'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                        'date': result['date'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location,
                    color: data['isDaytime'] ? Colors.black : Colors.grey,
                  ),
                  label: Text('Edit Location',
                    style: TextStyle(
                      color: data['isDaytime'] ? Colors.black : Colors.grey,
                    ),
                  )
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 3.0,
                          color: data['isDaytime'] ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 2.0,
                    color: data['isDaytime'] ? Colors.black : Colors.grey,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  data['date'],
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 3.0,
                    color: data['isDaytime'] ? Colors.black : Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

