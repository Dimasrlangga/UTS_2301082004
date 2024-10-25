import '../models/taxi.dart';

class TaxiService {
  Taxi createTaxi(
      String kodeTransaksi,
      String kodePenumpang,
      String namaPenumpang,
      String jenisPenumpang,
      String platNomor,
      String supir,
      double biayaAwal,
      double biayaPerKilometer,
      double jumlahKilometer) {
    return Taxi(
      kodeTransaksi: kodeTransaksi,
      kodePenumpang: kodePenumpang,
      namaPenumpang: namaPenumpang,
      jenisPenumpang: jenisPenumpang,
      platNomor: platNomor,
      supir: supir,
      biayaAwal: biayaAwal,
      biayaPerKilometer: biayaPerKilometer,
      jumlahKilometer: jumlahKilometer,
    );
  }
}