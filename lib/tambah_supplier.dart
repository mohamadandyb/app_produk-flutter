import 'package:app_produk/halaman_supplier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahSupplier extends StatefulWidget {
  const TambahSupplier({super.key});

  @override
  State<TambahSupplier> createState() => _TambahSupplierState();
}

class _TambahSupplierState extends State<TambahSupplier> {
  final formKey = GlobalKey<FormState>(); // Perbaikan: mendefinisikan formKey
  TextEditingController nama_supplier = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController no_telepon = TextEditingController();

  Future<bool> _simpan() async {
    final respon = await http.post(
        Uri.parse('http://10.0.2.2/api_mobile/supplier/create.php'),
        body: {
          'nama_supplier': nama_supplier.text,
          'alamat': alamat.text,
          'no_telepon': no_telepon.text,
        });
    return respon.statusCode == 200; // Menyederhanakan pengecekan statusCode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data Supplier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: formKey, // Menggunakan formKey yang sudah didefinisikan
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_supplier,
                decoration: InputDecoration(
                  hintText: 'Nama Supplier',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama supplier tidak boleh kosong!";
                  }
                  return null; // Perbaikan: harus ada return null jika valid
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  hintText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alamat tidak boleh kosong!";
                  }
                  return null; // Perbaikan: harus ada return null jika valid
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: no_telepon,
                decoration: InputDecoration(
                  hintText: 'No Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nomor Telepon tidak boleh kosong!";
                  }
                  return null; // Perbaikan: harus ada return null jika valid
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value
                            ? 'Data berhasil disimpan'
                            : 'Data gagal disimpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HalamanSupplier()),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
