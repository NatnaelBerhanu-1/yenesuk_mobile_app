import 'package:flutter/cupertino.dart';

class RetryWidget extends StatelessWidget{
  final Function onTap;
  final String message;

  RetryWidget({@required this.onTap, @required this.message}):assert(onTap!=null && message!=null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Text(
          '$message,\nTap to retry',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}