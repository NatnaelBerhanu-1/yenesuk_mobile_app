import 'package:flutter/material.dart';
import 'package:yenesuk/screens/homepage/homepage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.only(top: 40.0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                margin: EdgeInsets.only(bottom: 10.0, top: 50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(100.0))
                ),
              ),
              Text(
                'ABAY',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 100),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0
                                )
                            )
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+251'
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: VerticalDivider(
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'phone number',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                              'continue',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'by clicking continue you agree to our',
                textAlign: TextAlign.center,
                ),
              Text(
                'terms of service',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}