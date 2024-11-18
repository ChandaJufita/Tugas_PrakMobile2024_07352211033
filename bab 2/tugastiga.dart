// Enum untuk jenis bahan bakar
enum JenisBahanBakar {
  bensin,
  diesel,
  listrik,
}

// Mixin untuk fitur tambahan
mixin PemeliharaanMixin {
  void jadwalkanPemeliharaan() {
    print("${this.runtimeType} dijadwalkan untuk pemeliharaan.");
  }
}

// Abstract Class untuk Kendaraan
abstract class Kendaraan {
  // Atribut private
  String _merek;
  String _model;
  int _tahun;

  // Constructor dengan positional arguments
  Kendaraan(this._merek, this._model, this._tahun);

  // Getter untuk mendapatkan nilai atribut
  String get merek => _merek;
  String get model => _model;
  int get tahun => _tahun;

  // Setter untuk mengatur nilai atribut
  set merek(String merek) => _merek = merek;
  set model(String model) => _model = model;
  set tahun(int tahun) => _tahun = tahun;

  // Method abstrak
  void nyalakanMesin();
  void matikanMesin();
}

// Class Mobil yang menginherit Kendaraan dan menggunakan mixin PemeliharaanMixin
class Mobil extends Kendaraan with PemeliharaanMixin {
  // Atribut tambahan dengan named argument di constructor
  final JenisBahanBakar jenisBahanBakar;

  // Constructor dengan positional dan named arguments
  Mobil(String merek, String model, int tahun, {required this.jenisBahanBakar}) : super(merek, model, tahun);

  // Implementasi method nyalakanMesin
  @override
  void nyalakanMesin() {
    print("Mesin mobil dinyalakan. Jenis bahan bakar: ${jenisBahanBakar.name}");
  }

  // Implementasi method matikanMesin
  @override
  void matikanMesin() {
    print("Mesin mobil dimatikan.");
  }
}

// Class Motor yang menginherit Kendaraan
class Motor extends Kendaraan {
  // Atribut tambahan
  final bool adalahListrik;

  // Constructor dengan positional argument dan named argument
  Motor(String merek, String model, int tahun, {this.adalahListrik = false}) : super(merek, model, tahun);

  // Implementasi method nyalakanMesin
  @override
  void nyalakanMesin() {
    print(adalahListrik ? "Motor listrik dinyalakan." : "Motor bensin dinyalakan.");
  }

  // Implementasi method matikanMesin
  @override
  void matikanMesin() {
    print("Mesin motor dimatikan.");
  }
}

void main() {
  // Membuat objek Mobil
  var mobilSaya = Mobil("Toyota", "Avanza", 2022, jenisBahanBakar: JenisBahanBakar.bensin);
  mobilSaya.nyalakanMesin();
  mobilSaya.jadwalkanPemeliharaan();
  mobilSaya.matikanMesin();

  // Membuat objek Motor
  var motorSaya = Motor("Yamaha", "NMAX", 2021, adalahListrik: false);
  motorSaya.nyalakanMesin();
  motorSaya.matikanMesin();
}
