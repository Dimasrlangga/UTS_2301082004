import 'package:flutter/material.dart';
import 'models/taxi.dart';
import 'services/taxi_service.dart';

void main() {
  runApp(TaxiApp());
}

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaxiForm(),
    );
  }
}

class TaxiForm extends StatefulWidget {
  @override
  _TaxiFormState createState() => _TaxiFormState();
}

class _TaxiFormState extends State<TaxiForm> {
  final _kodeTransaksiController = TextEditingController();
  final _kodePenumpangController = TextEditingController();
  final _namaPenumpangController = TextEditingController();
  final _platNomorController = TextEditingController();
  final _supirController = TextEditingController();
  final _biayaAwalController = TextEditingController();
  final _biayaPerKilometerController = TextEditingController();
  final _jumlahKilometerController = TextEditingController();

  String _jenisPenumpang = 'VIP'; // Default selection
  String _totalBayar = '';

  void _hitungTotalBayar() {
    final taxiService = TaxiService();
    
    Taxi taxi = taxiService.createTaxi(
      _kodeTransaksiController.text,
      _kodePenumpangController.text,
      _namaPenumpangController.text,
      _jenisPenumpang,
      _platNomorController.text,
      _supirController.text,
      double.tryParse(_biayaAwalController.text) ?? 0,
      double.tryParse(_biayaPerKilometerController.text) ?? 0,
      double.tryParse(_jumlahKilometerController.text) ?? 0,
    );

    setState(() {
      _totalBayar = 'Total Bayar: Rp ${taxi.hitungTotalBayar().toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Taxi')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kodeTransaksiController,
              decoration: InputDecoration(labelText: 'Kode Transaksi'),
            ),
            TextField(
              controller: _kodePenumpangController,
              decoration: InputDecoration(labelText: 'Kode Penumpang'),
            ),
            TextField(
              controller: _namaPenumpangController,
              decoration: InputDecoration(labelText: 'Nama Penumpang'),
            ),
            DropdownButtonFormField<String>(
              value: _jenisPenumpang,
              decoration: InputDecoration(labelText: 'Jenis Penumpang'),
              items: ['VIP', 'GOLD'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _jenisPenumpang = newValue!;
                });
              },
            ),
            TextField(
              controller: _platNomorController,
              decoration: InputDecoration(labelText: 'Plat Nomor'),
            ),
            TextField(
              controller: _supirController,
              decoration: InputDecoration(labelText: 'Nama Supir'),
            ),
            TextField(
              controller: _biayaAwalController,
              decoration: InputDecoration(labelText: 'Biaya Awal'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _biayaPerKilometerController,
              decoration: InputDecoration(labelText: 'Biaya Per Kilometer'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jumlahKilometerController,
              decoration: InputDecoration(labelText: 'Jumlah Kilometer'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitungTotalBayar,
              child: Text('Hitung Total Bayar'),
            ),
            SizedBox(height: 20),
            Text(
              _totalBayar,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
