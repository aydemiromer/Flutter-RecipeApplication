class Kategori {
  String kategori_id;
  String kategori_ad;

  Kategori(this.kategori_id, this.kategori_ad);

  factory Kategori.fromJson(String key, Map<dynamic, dynamic> json) {
    return Kategori(key, json["kategori_ad"] as String);
  }
}
