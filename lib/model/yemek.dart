class Yemekler {
  String yemek_id;
  String Yemek_adi;
  int Suresi;
  String star_rate;
  String star_counter;
  String star_total;
  String resim;
  String kategori_ad;
  String Tarif;
  String Malzemesi;
  List rating;

  Yemekler(this.yemek_id,
      this.Yemek_adi,
      this.Suresi,
      this.resim,
      this.kategori_ad,
      this.Tarif,
      this.Malzemesi,
      this.star_counter,
      this.rating,

      this.star_rate,
      this.star_total);

  factory Yemekler.fromJson(String key, Map<dynamic, dynamic> json) {
    return Yemekler(
      key,
      json["Yemek_adi"] as String,
      json["Suresi"] as int,
      json["resim"] as String,
      json["kategori_ad"] as String,
      json["Tarif"] as String,
      json["Malzemesi"] as String,
      json["star_counter"] as String,
      json["rating"] as List,

      json["star_rate"] as String,

      json["yemek_id"] as String,

    );
  }

  Yemekler.fromMap(Map<dynamic, dynamic>map)
      : Yemek_adi = map['yemekAdi'],
        yemek_id=map['id'],
        Suresi=map['sure'],
        Malzemesi=map['malzeme'],
        rating=map['rating'],
        kategori_ad=map['kategori'],
        resim=map['resim'],
        Tarif=map['tarif'];


  @override
  String toString() {
    // TODO: implement toString
    return 'Yemek ; Yemek adi : $Yemek_adi ,YemekID :$yemek_id, rating: $rating ,Suresi : $Suresi , gorsel : $resim , kategori adı :$kategori_ad , Tarif : $Tarif , Malzeme :$Malzemesi ,';
  }
}
