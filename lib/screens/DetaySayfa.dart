import 'package:flutter_firebase_get/model/yemek.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  Yemekler yemek;

  DetaySayfa({this.yemek});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  double _rating;
  List<Yemekler> yemekList = [];
  int ratedCheck = 0;
  String streamGelenRate = "";

  final name = "star_rate";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("tarif idsi    " + widget.yemek.yemek_id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.yemek.Yemek_adi),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    widget.yemek.resim,
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Hazırlama Süresi: ${widget.yemek.Suresi}" + "dk"),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      starButton(context),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("yemekler")
                              .doc(widget.yemek.yemek_id)
                              .snapshots(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              var gelenData = snapshot.data;
                              var yemek = Yemekler.fromMap(gelenData.data());

                              String rate = rateCreate(yemek);
                              streamGelenRate = rate;
                              return Text(rate);
                            } else {
                              return SizedBox();
                            }
                          })
                      // Text(
                      //   ' ${widget.yemek.star_rate}.0 / 5.0',
                      //   style: Theme.of(context).textTheme.subtitle1,
                      // ),
                    ],
                  ),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              TextS(
                name: "MALZEMELER",
              ),
              Text(
                widget.yemek.Malzemesi,
                style: TextStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              TextS(
                name: "TARİFİ",
              ),
              Text(widget.yemek.Tarif),
              SizedBox(
                height: 10,
              ),
              TextS(
                name: "ÖNERİLER",
              ),
              SizedBox(
                  height: 15.0,
                  width: 100.0,
                  child: Divider(
                    color: Colors.orange,
                    thickness: 1,
                  )),
              Container(
                height: 190,
                color: Colors.transparent,
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("Yemekler")
                      .orderByChild("star_rate")
                      .equalTo("5")
                      .limitToFirst(50)
                      .onValue,
                  builder:
                      (BuildContext context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      List yemeklerSayfaListesi = <Yemekler>[];

                      var gelenDegerler = snapshot.data.snapshot.value;

                      if (gelenDegerler != null) {
                        gelenDegerler.forEach((key, nesne) {
                          var gelenYemek = Yemekler.fromJson(key, nesne);

                          if (gelenYemek.kategori_ad ==
                                  widget.yemek.kategori_ad &&
                              gelenYemek.Yemek_adi != widget.yemek.Yemek_adi) {
                            // print(gelenYemek.kategori_ad);
                            yemeklerSayfaListesi.add(gelenYemek);
                          }
                        });

                        print(yemeklerSayfaListesi.length);
                        yemekList = yemeklerSayfaListesi;
                        yemeklerSayfaListesi.shuffle();
                        //  print("gelen yemekler list");
                        //    print(YemeklerSayfaListesi.length);
                      }
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: yemeklerSayfaListesi.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, crossAxisSpacing: 1),
                          itemBuilder: (BuildContext context, int index) {
                            return Denemecard(
                                yemek: yemeklerSayfaListesi[index]);
                          });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton starButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.star,
          color: Colors.yellowAccent[700],
          size: 31,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Yemeği puanla :)"),
                  actions: [
                    RatingBar(
                      onRatingChanged: (rating) {
                        setState(() {
                          _rating = rating;
                          ratedCheck++;
                        });
                      },
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: false,
                      filledColor: Colors.yellow,
                      emptyColor: Colors.grey,
                      halfFilledColor: Colors.amberAccent,
                      size: 48,
                    ),
                    SizedBox(height: 32),
                    /*Text(
                      'Rating : $streamGelenRate',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),*/








































                    
                    TextButton(
                        onPressed: () async {
                          //buraya butonu yazdırıcak fonk gerekli denerken dikkatli olalım, db üzerine başka yerlere ekleme yapılabiliyor ekleme olursa silinsin gereksiz eklemeler.
                          /* refYemekler

                              .child(widget.yemek.star_rate)
                              .push()
                              .child(widget.yemek.star_rate)
                              .set(_rating)
                              .asStream();*/

                          if (ratedCheck == 1) {
                            try {
                              print(
                                  "rate update edilecek yemek idsi ${widget.yemek.yemek_id}: yemek adi${widget.yemek.Yemek_adi}");

                              await FirebaseFirestore.instance
                                  .collection("yemekler")
                                  .doc(widget.yemek.yemek_id)
                                  .update({
                                "rating":
                                    FieldValue.arrayUnion([_rating.toInt()])
                              });
                            } catch (e) {
                              print(e);
                            }

                            Fluttertoast.showToast(
                                msg:
                                    "Tebrkikler  🎉🎉🎉 tarife ${_rating.toInt().toString()} yıldız verdiniz",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.white,
                                textColor: Colors.blue[800],
                                fontSize: 16.0);

                            Navigator.of(context).pop();
                          } else if (ratedCheck > 1) {
                            print("rate leme yapıldı");
                            Fluttertoast.showToast(
                                msg: "Zaten tarife yıldız verdin !!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Finish"))
                  ],
                );
              });
        });
  }

  ratingCreate() async {
    List newList = [];

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("yemekler")
        .doc(widget.yemek.yemek_id)
        .get();

    var yemek = Yemekler.fromMap(documentSnapshot.data());

    newList = yemek.rating;
    print("new list $newList");
    print(newList.length);
    double ratingToplam = 0.0;
    double ortalamaRating = 0.0;

    for (var i in newList) {
      print(ratingToplam);
      ratingToplam += i;
    }

    ortalamaRating = ratingToplam / newList.length;
    print("ortalama rating $ortalamaRating");
    return ortalamaRating;
  }

  rate() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot _querysnapshot;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("yemekler")
        .doc(widget.yemek.yemek_id)
        .get();

    var yemek = Yemekler.fromMap(documentSnapshot.data());

    return yemek;

// _querysnapshot= await   firebaseFirestore.collection("yemekler").get();
//
// List<Yemekler> gelenYemekList=[];
//     for (DocumentSnapshot snap in _querysnapshot.docs) {
//       var yemek=Yemekler.fromMap(snap.data());
//       gelenYemekList.add(yemek);
//     }
//ratingCreate(gelenYemekList);
    // for (int i = 0; i < yemekList.length; i++) {
    //   firebaseFirestore.collection("yemekler").doc(yemekList[i].yemek_id).set({
    //     "yemekAdi": yemekList[i].Yemek_adi,
    //     "sure": yemekList[i].Suresi,
    //     "tarif": yemekList[i].Tarif,
    //     "id": yemekList[i].yemek_id,
    //     "kategori": yemekList[i].kategori_ad,
    //     "rating": yemekList[i].rating,
    //     "resim": yemekList[i].resim,
    //     "malzeme": yemekList[i].Malzemesi,
    //   });
    // }
  }

  String rateCreate(Yemekler yemek) {
    double ortalamaRating = 0.0;

    for (var i in yemek.rating) {
      ortalamaRating += i;
    }
    ortalamaRating = ortalamaRating / yemek.rating.length;
    print("ortalama rating ve yemek list uzunlugu kac adet oy var");
    print(yemek.rating.length);
    print("ortalama rating");
    print(ortalamaRating);

    return ortalamaRating.toStringAsFixed(2);
  }
}

class TextS extends StatelessWidget {
  final String name;

  const TextS({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      height: 20,
    );
  }
}

class Denemecard extends StatelessWidget {
  Yemekler yemek;

  Denemecard({this.yemek});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetaySayfa(
                      yemek: yemek,
                    )));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(1),
              height: 180,
              width: 180,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    Image.network(
                      this.yemek.resim,
                      height: 120,
                      filterQuality: FilterQuality.high,
                      // fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(this.yemek.Yemek_adi)
                  ],
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
      ),
    );
  }
}
