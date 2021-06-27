import 'package:flutter/material.dart';
import 'package:flutter_firebase_get/model/yemek.dart';

class YemekCardWidget extends StatelessWidget {
  const YemekCardWidget({Key key, @required this.yemek, this.screenSize})
      : super(key: key);

  final Yemekler yemek;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
          child: Stack(
        children: [
          // Resim
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  yemek.resim,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // **********************

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 20,
                color: Colors.grey.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        yemek.Yemek_adi,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}


/*  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.network(
              yemek.resim,
              height: 120.0,
              width: 200.0,
              filterQuality: FilterQuality.high,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            yemek.Yemek_adi,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ), */