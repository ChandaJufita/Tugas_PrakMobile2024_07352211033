
enum JenisBahanBakar {
  bensin,
  diesel,
  listrik,
}
mixin PemeliharaanMixin {
  void jadwalkanPemeliharaan() {
    print("${this.runtimeType} dijadwalkan untuk pemeliharaan.");
  }
}
abstract class Kendaraan {
  String _merek;
  String _model;
  int _tahun;
  Kendaraan(this._merek, this._model, this._tahun);

  String get merek => _merek;
  String get model => _model;
  int get tahun => _tahun;
  set merek(String merek) => _merek = merek;
  set model(String model) => _model = model;
  set tahun(int tahun) => _tahun = tahun;
  void nyalakanMesin();
  void matikanMesin();
}

class Mobil extends Kendaraan with PemeliharaanMixin {
  final JenisBahanBakar jenisBahanBakar;
  Mobil(String merek, String model, int tahun, {required this.jenisBahanBakar}) : super(merek, model, tahun);
  @override
  void nyalakanMesin() {
    print("Mesin mobil dinyalakan. Jenis bahan bakar: ${jenisBahanBakar.name}");
  }
  @override
  void matikanMesin() {
    print("Mesin mobil dimatikan.");
  }
}

class Motor extends Kendaraan {
  final bool adalahListrik;
  Motor(String merek, String model, int tahun, {this.adalahListrik = false}) : super(merek, model, tahun);
  @override
  void nyalakanMesin() {
    print(adalahListrik ? "Motor listrik dinyalakan." : "Motor bensin dinyalakan.");
  }
  @override
  void matikanMesin() {
    print("Mesin motor dimatikan.");
  }
}

void main() {

  var mobilSaya = Mobil("Toyota", "Avanza", 2022, jenisBahanBakar: JenisBahanBakar.bensin);
  mobilSaya.nyalakanMesin();
  mobilSaya.jadwalkanPemeliharaan();
  mobilSaya.matikanMesin();

  var motorSaya = Motor("Yamaha", "NMAX", 2021, adalahListrik: false);
  motorSaya.nyalakanMesin();
  motorSaya.matikanMesin();
}
