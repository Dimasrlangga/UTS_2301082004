import 'package:flutter/material.dart';

class Taxi {
  String kodeTransaksi;
  String kodePenumpang;
  String namaPenumpang;
  String jenisPenumpang;
  String platNomor;
  String supir;
  double biayaAwal;
  double biayaPerKilometer;
  double jumlahKilometer;

  Taxi({
    required this.kodeTransaksi,
    required this.kodePenumpang,
    required this.namaPenumpang,
    required this.jenisPenumpang,
    required this.platNomor,
    required this.supir,
    required this.biayaAwal,
    required this.biayaPerKilometer,
    required this.jumlahKilometer,
  });

  double hitungTotalBayar() {
    double gratisKm = 0;

    if (jenisPenumpang.toUpperCase() == "VIP") {
      gratisKm = 5;
    } else if (jenisPenumpang.toUpperCase() == "GOLD") {
      gratisKm = 2;
    }

    double kmDikenakanBiaya = (jumlahKilometer > gratisKm) ? (jumlahKilometer - gratisKm) : 0;
    return biayaAwal + (biayaPerKilometer * kmDikenakanBiaya);
  }
}

class TaxiForm extends StatefulWidget {
  @override
  _TaxiFormState createState() => _TaxiFormState();
}

class _TaxiFormState extends State<TaxiForm> {
  String selectedJenisPenumpang = "VIP"; // Default value, only "VIP" and "GOLD" are available now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Taxi Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pilih Jenis Penumpang"),
            DropdownButton<String>(
              value: selectedJenisPenumpang,
              items: <String>['VIP', 'GOLD'].map((String value) { // Removed "REGULAR"
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedJenisPenumpang = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Taxi taxi = Taxi(
                  kodeTransaksi: "TRX123",
                  kodePenumpang: "PN123",
                  namaPenumpang: "John Doe",
                  jenisPenumpang: selectedJenisPenumpang,
                  platNomor: "B 1234 XYZ",
                  supir: "Budi",
                  biayaAwal: 5000,
                  biayaPerKilometer: 2000,
                  jumlahKilometer: 10,
                );

                double totalBayar = taxi.hitungTotalBayar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Total Bayar: $totalBayar")),
                );
              },
              child: Text("Hitung Total Bayar"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: TaxiForm()));
