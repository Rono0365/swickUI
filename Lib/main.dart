import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Netcloud.dart';
import 'splash.dart';
import 'menu.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'receipt.dart';
import 'dart:core';
import 'dines.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
void main() {
  MpesaFlutterPlugin.setConsumerKey('8MB6JEgt01F0rxfHkQDGQhf6pf6JGgNn');
  MpesaFlutterPlugin.setConsumerSecret('pZSV0W1k4urlQH54');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,     
      theme: ThemeData(primarySwatch: Colors.green,
      ),
        home:screen()));/* MyApp()SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black45.withOpacity(0.5), */
        
  
        }

class MyApp extends StatefulWidget {
  MyApp(
      {Key? key,
      required this.title,
      required this.token,
      required this.userid})
      : super(key: key);

  final String title;
  final String token;
  final String userid;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> startCheckout({required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: userPhone,
              partyB: "174379",
              callBackURL: Uri(scheme: "https", host : "1234.1234.co.ke", path: "/1234.php"),
              accountReference: "shoe",
              phoneNumber: userPhone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey: '0842');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }
  String _scanBarcode = 'Unknown';
  var tablename;
  var name;
  var sky;
  var sky2;
  var food1;
  var food2;
  var food3;
  var id;
  var value2;
  var value3;
  var valuey;
  var valuez;
Future getWeather3x() async {
      String token = widget.token.toString();
    
      print('here'+token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
          http.Response responsev = //http://172.16.12.17:8000/
              await http.get(Uri.parse('http://192.168.100.20:8000/restaurant/1/'),headers: headers);
          var results = jsonDecode(responsev.body);
          setState(() {
            this.sky = results;
          });
          print(sky);
  }
  
  Future getMe() async {
      String token = widget.token.toString();
      String id = widget.userid.toString();
      
      print('here'+token);
      print('here'+id);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
          http.Response responsev =
              await http.get(Uri.parse('http://192.168.100.20:8000/me/$id'),headers: headers);
          var xcv = jsonDecode(responsev.body);
          setState(() {
            this.sky2 = xcv;
          });
          print(sky2);
  }
  Future getWealth() async {
      String token = widget.token.toString();
      String id = widget.userid.toString();
      
      print('here'+token);
      print('here'+id);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
          http.Response responsev =
              await http.get(Uri.parse('http://192.168.100.20:8000/order/'),headers: headers);
          var xcv = jsonDecode(responsev.body);
          setState(() {
            this.food1 = xcv;
          });
          print(food1);
  }
  @override
  void initState() {
    super.initState();
    //this.getWeather3x();
    this.getMe();
    this.getWealth();
  }

  

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      
    Future getWeather(String k) async {
      String token = widget.token.toString();
    
      print('here'+token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
          http.Response responsev =
              await http.get(Uri.parse('http://192.168.100.20:8000/restaurant/'+k),headers: headers);
          var results = jsonDecode(responsev.body);
          setState(() {
            this.sky = results;
          });
          print(sky['username'].toString());
  }
  

      //here's  functs
      
  void senE(BuildContext context) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Invalid account"),
            content: Text("Didn't get the qrcode"),
          ),
        );
      }
    void senTT(BuildContext context) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("$_scanBarcode Successfully Added"),
            ),
          );
        }

      
      //add the http request here
      
    
    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode.toString());
      final id = _scanBarcode.length;
      print(barcodeScanRes.substring(2,id));
      //this.getWeather(_scanBarcode.toString());
    });
    //if (barcodeScanRes != true) return _launchURL(_scanBarcode.toString());
 if (barcodeScanRes.toString() != '-1'){
        //senTT(context);
        print(barcodeScanRes.length);
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Rutimetable(title:barcodeScanRes.substring(0,1),token:widget.token.toString(),user:barcodeScanRes.substring(2,id),me:sky2['username'].toString()),// sky2['username']
                        ),
                      );
        
      
  
        //GetData(barcodeScanRes.toString());
         //senTT(context);
      }else{
        print("Not a good url");
        senE(context);
        
      }
  }

      
  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    
    return  sky2 != null?Scaffold(
          backgroundColor:Colors.white,
            /*appBar: AppBar(
              backgroundColor:Colors.yellow,
              elevation:0.0,
          centerTitle:true,    
              title: const Text('',style:TextStyle(color:Colors.amber)),
              actions:[
                CircleAvatar(
                  radius:15,
                  child:Icon(
                    Icons.person,
                    size:20
                  )
                ),
                SizedBox(width:5),
              ]
              ),*/
              
            body:SingleChildScrollView(
              child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                
              //SizedBox(height:100),
                Wrap(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width:MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height*0.24,
                      //color:Colors.grey,
                      decoration: const BoxDecoration(
    image: DecorationImage(
        alignment: Alignment(-.2, 0),
        image: AssetImage(
            'assets/swick003.jpeg'),
        fit: BoxFit.cover),
  ),
  child:Center(child:Column( 
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      
ListTile(
  title:  Text("Swick.",style:TextStyle(color:Colors.yellow[700],fontWeight:FontWeight.bold,fontSize:30)),
      
  
  trailing:InkWell(child:CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey[900],
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.yellow[700],
                      ),
                    ),onTap:(){
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => traktar(
                        title:food1.toList(),
                        title1:sky2['username'].toString(),
                      )));
                    }),//food1
),
ListTile(),
    
  ])),
                 //     child:Image.asset('assets/swick001.jpeg')
                    ),
                //*/
                ]),
                SingleChildScrollView(child:Row(children:[
                  Container(height:MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width
                
                ,
                child:Column(
                  children:[
                    Container(
                      width:MediaQuery.of(context).size.width,
                      //color:Colors.grey.withOpacity(0.2),
                      child:Column(children:[
                      /*CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey[900],
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.red,
                      ),
                    ),*/
                      Text("" ,style: TextStyle(
                        fontWeight:FontWeight.w400,
                        
    //backgroundColor:Colors.black12,
                 color: Colors.grey[900]),textAlign: TextAlign.center,
          )]),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height*0.077,),
                Container(height: MediaQuery.of(context).size.height*0.07,
                   width: MediaQuery.of(context).size.width,
                   child: Text("Hello ,${sky2['username']}.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27), textAlign: TextAlign.center,)),
                    SizedBox(height:MediaQuery.of(context).size.height*.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   
                      children:[
                      Tab(
                    icon:CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green[100],
                      child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.red,
                      ),
                    )),
                    child: Text("Ease of use",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    //text: ,
                    //  backgroundColor: Colors.grey[50],
                  ),  Tab(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green[100],
                      child:CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.
access_time_rounded,
                        color: Colors.red,
                      ),
                    )),
                    child: Text("Fast",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    //text: ,
                    //  backgroundColor: Colors.grey[50],
                  ),  Tab(
                    icon:CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green[100],
                      child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.accessibility_outlined,
                        color: Colors.red,
                      ),
                    )),
                    child: Text("Easy",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    //text: ,
                    //  backgroundColor: Colors.grey[50],
                  ),  Tab(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green[100],
                      child:CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.room_service_outlined,
                        color: Colors.red,
                      ),
                    )),
                    child: Text("dine-in",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    //text: ,
                    //  backgroundColor: Colors.grey[50],
                  ),Tab(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green[100],
                      child:CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.medical_services_outlined,
                        color: Colors.red,
                      ),
                    )),
                    child: Text("safe",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    //text: ,
                    //  backgroundColor: Colors.grey[50],
                  ),
                    ])
                    
                  ]
                )
                ),
                ])),
                //SizedBox(height:MediaQuery.of(context).size.height*0.42),
                
              
                  /*Container(height:300,width:MediaQuery.of(context).size.width*0.8
                  ,
                  child:Card(
                    color:Colors.grey.withOpacity(0.3),
                    elevation:0.0,
                    child:Column(
                      children:[
                        SizedBox(height:MediaQuery.of(context).size.height*0.02),
                
                        ListTile(
                          title:CircleAvatar(
                            radius:30,
                            child:Center(
                              child:Icon(Icons.person)
                            )
                          ),
                        ),
                         ListTile(
                          title:Row(
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children:[Text("Hello Rono",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:26))]),
                
                        ),
                        
                         ListTile(
                          leading:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[Text("Restaurants",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:20)),Text(""),Text(""),Text("Orders",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:20))]),
                          //trailing:Text("Restaurants"),
                        ),
                        ListTile(
                          leading:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[Text("3",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:20)),Text(""),Text(""),Text("7",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:20))]),
                          //trailing:Text("Restaurants"),
                        ),
                       


                      ]
                    )
                  )
                  ),*/
                  //SizedBox(height:MediaQuery.of(context).size.width*0.02),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
     
               Container(
            height: 95,
            width: 95,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () => scanQR(),
              child: Container(height: 50,
            width: 50,child:Image.asset('assets/swickqr-removebg-preview.png'))
            ))
          
                    ]
                  ),*/
             
           SizedBox(height:MediaQuery.of(context).size.height*0.08),
           FloatingActionButton.extended(
            backgroundColor: Colors.green,
            icon: Icon(Icons.flatware_outlined),
            label: Text("scan QR to Order"),
            onPressed: () => scanQR(),
            

            // This trailing comma makes auto-formatting nicer for build methods.
        )
       ,SizedBox(height:MediaQuery.of(context).size.height*0.1),
          
        //SizedBox(height:MediaQuery.of(context).size.height*0.05),
        Text(''),          
          
                //Text(_scanBarcode.toString()),
                ]
            ), 
            )
            ,
            
            //floatingbutton
            floatingActionButtonLocation: 
            
            
            FloatingActionButtonLocation.centerFloat,
     
            floatingActionButton:Text("Powered by\nXmobol",textAlign:TextAlign.center), //©
            /*FloatingActionButton.extended(
            backgroundColor: Colors.green,
            icon: Icon(Icons.flatware_outlined),
            label: Text("scan QR to Order"),
            onPressed: () => scanQR(),
            

            // This trailing comma makes auto-formatting nicer for build methods.
        )*/ ):Scaffold(body:Center(child:
   Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(''), ListTile(title:Text("")),Center(
                    child: CircularProgressIndicator(),
                  )])));
  }
}