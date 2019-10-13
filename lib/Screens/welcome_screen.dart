import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/Weclcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
  
List<String> imageUrl =  
        [
        'https://thumbs.gfycat.com/ShyCautiousAfricanpiedkingfisher-size_restricted.gif',
        ];
        int counter =1;
       // IconData  varIcon = Icons.delete_outline;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    final userData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
        
        double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: scaffoldKey,
        body: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                
                    color:  Colors.white60
              )),
              Container(
                height: screenHeight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            child: Text('FOSTAY'),
                            color: Colors.white70,
                            onPressed: () {
                              // signOutProviders();
                              Toast.show("Thanks for Booking", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              Navigator.of(context).pop(null);
                            })
                      ],
                    ),
                    Center(
                      child: Card(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:20, vertical: 20),
                          child: Column(
                            children: <Widget>[
                              new Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black87)),
                                child: Text(
                                  'Hi ${userData['name']}',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black87),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Your Accomodation is accepted',
                                style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Column(children: <Widget>[
                                      Container(
                                color: Colors.transparent,
                                height: screenHeight*0.48,
                                child: ListView.builder(
                                  itemCount: counter,
                                  itemBuilder: (context,index){
                                    print(counter);
                                    return Card(child: Image.network(imageUrl[index]));
                                  },
                                  
                                ),
                              )
                              ],),
                              Container(color: Colors.yellow,
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.green,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.red,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
    child: new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.account_balance),
          title: new Text("#2242"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.delete),
          title: new Text("Cancel"),
        )
      ],
    ),
  ),
        ));
  }
}
