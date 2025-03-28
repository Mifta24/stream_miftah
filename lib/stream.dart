import 'package:flutter/material.dart';
import 'dart:async';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    Colors.pink,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.lime,
  ];

// Untuk menghasilkan stream yang mengeluarkan warna secara berulang setiap detik
  Stream<Color> getColors() async* {
    // yield* digunakan untuk mengeluarkan nilai dari stream yang diberikan
    // Stream.periodic() menghasilkan stream yang mengeluarkan nilai berulang setiap durasi yang diberikan
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      int index = t % colors.length;
      return colors[index];
    });
  }
}

class NumberStream {
  // StreamController adalah objek yang mengelola stream dan sink
  final StreamController<int> controller = StreamController<int>();

  void addNumberToSink(int newNumber) {
    // Menambahkan angka baru ke dalam sink
    // sink adalah tempat untuk menambahkan data ke dalam stream
    controller.sink.add(newNumber);
  }

  close() {
    // Menutup sink untuk menghentikan aliran data
    controller.close();
  }
}
