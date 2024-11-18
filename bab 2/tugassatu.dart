import 'dart:async';

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

abstract class Karyawan {
  String nama;
  int umur;
  String peran;
  bool aktif = true;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void resign() {
    aktif = false;
    print('$nama telah resign.');
  }

  void bekerja();
}

mixin Kinerja on Karyawan {
  int produktivitas = 50;
  DateTime? waktuTerakhirUpdate;

  void updateProduktivitas(int nilai) {
    DateTime sekarang = DateTime.now();
    if (waktuTerakhirUpdate == null || sekarang.difference(waktuTerakhirUpdate!).inDays >= 30) {
      produktivitas = (nilai < 0) ? 0 : (nilai > 100) ? 100 : nilai;
      waktuTerakhirUpdate = sekarang;
      print('Produktivitas $nama diperbarui menjadi $produktivitas.');
    } else {
      print('Produktivitas hanya bisa diperbarui setiap 30 hari.');
    }
  }
}

class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama (Karyawan Tetap) sedang bekerja.');
  }
}

class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama (Karyawan Kontrak) sedang bekerja pada proyek.');
  }
}

class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;
  int jumlahTerjual = 0;

  ProdukDigital(this.namaProduk, this.harga, this.kategori) {
    if (kategori == "NetworkAutomation" && harga < 200000) {
      throw Exception("Harga NetworkAutomation harus minimal 200.000");
    } else if (kategori == "DataManagement" && harga >= 200000) {
      throw Exception("Harga DataManagement harus di bawah 200.000");
    }
  }

  void terapkanDiskon() {
    if (kategori == "NetworkAutomation" && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.85;
      harga = hargaDiskon >= 200000 ? hargaDiskon : 200000;
      print('Diskon diterapkan. Harga baru: $harga');
    }
  }
}

class Proyek {
  String namaProyek;
  FaseProyek fase = FaseProyek.Perencanaan;
  List<Karyawan> anggotaTim = [];
  DateTime tanggalMulai = DateTime.now();

  Proyek(this.namaProyek);

  void tambahAnggotaTim(Karyawan karyawan) {
    if (anggotaTim.length < 20) {
      anggotaTim.add(karyawan);
      print('${karyawan.nama} ditambahkan ke tim proyek.');
    } else {
      print('Tim sudah mencapai kapasitas maksimum.');
    }
  }

  void lanjutKeFaseBerikutnya() {
    if (fase == FaseProyek.Perencanaan && anggotaTim.length >= 5) {
      fase = FaseProyek.Pengembangan;
      print('Proyek beralih ke fase Pengembangan.');
    } else if (fase == FaseProyek.Pengembangan &&
        DateTime.now().difference(tanggalMulai).inDays > 45) {
      fase = FaseProyek.Evaluasi;
      print('Proyek beralih ke fase Evaluasi.');
    } else {
      print('Syarat untuk beralih ke fase berikutnya belum terpenuhi.');
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      karyawanAktif.add(karyawan);
      print('${karyawan.nama} ditambahkan sebagai karyawan aktif.');
    } else {
      print('Jumlah maksimum karyawan aktif tercapai.');
    }
  }

  void hapusKaryawan(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawan.resign();
    karyawanNonAktif.add(karyawan);
    print('${karyawan.nama} dipindahkan ke daftar karyawan non-aktif.');
  }
}

void main() {
  var produk1 = ProdukDigital("Sistem Data", 150000, "DataManagement");
  var produk2 = ProdukDigital("Otomasi Jaringan", 250000, "NetworkAutomation");

  produk2.jumlahTerjual = 60;
  produk2.terapkanDiskon();

  var karyawan1 = KaryawanTetap("Chanda", umur: 19, peran: "Developer");
  var karyawan2 = KaryawanKontrak("Jufita", umur: 19, peran: "NetworkEngineer");

  karyawan1.bekerja();
  karyawan2.bekerja();

  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);

  karyawan1.updateProduktivitas(90);
  karyawan2.updateProduktivitas(80);

  var proyek = Proyek("Digital Transformation");
  proyek.tambahAnggotaTim(karyawan1);
  proyek.tambahAnggotaTim(karyawan2);

  proyek.lanjutKeFaseBerikutnya();
}
