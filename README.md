# Tugas Flutter State Management dengan Streams

Miftahudin Aldi Saputra - 1122140079

## Deskripsi Proyek

Proyek Flutter yang mendemonstrasikan statre management dengan streams.

## Laporan Praktikum

### Soal no 1

Menambahkan nama panggilan pada title app sebagai identitas hasil pekerjaan dan mengganti warna tema sesuai kesukaan.

```dart
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Miftah',
      theme: ThemeData(
        Gantilah warna tema aplikasi sesuai kesukaan Anda.
primarySwatch: Colors.lightGreen,
      ),
      home: const StreamHomePage(),
    );
 }
```

### Soal no 2

Menambahkan 5 warna lainnya sesuai keinginan Anda pada variabel colors

```dart
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
```

### Soal No 3

Jelaskan fungsi keyword yield\* pada kode tersebut!

```dart
 yield* Stream.periodic(const Duration(seconds: 1), (int t))
```

#### Penjelasan

yield\* berfungsi mengambil seluruh nilai dari stream yang direferensikan dan meneruskannya satu per satu ke stream yang sedang dibuat.

Apa maksud isi perintah kode tersebut?

```dart
 Stream<Color> getColors() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      int index = t % colors.length;
      return colors[index];
    });
  }
```

#### Penjelasan

Kode ini membuat sebuah stream yang:

- Mengeluarkan warna dari array colors secara berurutan
- Berganti warna setiap 1 detik
- Setelah mencapai warna terakhir di array, kembali lagi ke - warna pertama (berputar)

### Soal No 4

#### Demo

![Capture no 4](/images/captureno4.gif)

### Soal No 5

Jelaskan perbedaan menggunakan listen dan await for (langkah 9) !

Kedua pendekatan yang Anda tunjukkan digunakan untuk mengonsumsi nilai dari stream, tetapi memiliki perbedaan mendasar dalam cara kerja dan penggunaannya:

```dart
//langkah 9
await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }

```

##### Karakteristik:

- Menggunakan sintaks async/await yang membutuhkan fungsi yang diawali dengan async
- Memblokir eksekusi fungsi saat ini sampai stream selesai (completed)
- Kode setelah loop await for tidak akan dijalankan sampai stream berakhir
- Lebih mudah dibaca dan mirip dengan sintaks loop pada umumnya
- Cocok untuk stream yang pasti berakhir

```dart

//langkah 13
colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
```

##### Karakteristik:

- Menggunakan pendekatan callback
- Non-blocking - eksekusi fungsi terus berlanjut setelah memanggil listen()
- Callback dijalankan setiap kali ada event baru dari stream
- Memberikan lebih banyak kontrol (bisa menambahkan handler untuk error, completion, dsb)
- Cocok untuk stream yang terus berjalan (continuous stream)

##### Kesimpulan

- Langkah 9 (await for) tidak ideal untuk stream tak terbatas seperti yang dihasilkan oleh getColors() karena akan memblokir eksekusi fungsi selamanya.

- Langkah 13 (listen) adalah pendekatan yang lebih tepat untuk kasus ini, karena:

Tidak memblokir eksekusi fungsi
Memungkinkan UI untuk tetap responsif
Cocok untuk stream yang terus menghasilkan nilai tanpa batas waktu

### Soal No 6

Jelaskan maksud kode langkah 8 dan 10 tersebut!

```dart
//Langkah 8
@override
  void initState() {
    numberStream = NumberStream();
    NumberStreamController = numberStream.controller;
    Stream stream = NumberStreamController.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });
    super.initState();
  }
```

#### Penjelasan

1. Inisialisasi NumberStream: Membuat instance dari kelas NumberStream (yang sudah didefinisikan di stream.dart).

2. Akses StreamController: Mengambil referensi controller dari numberStream dan menyimpannya dalam variabel NumberStreamController.

3. Mendapatkan Stream: Mengakses stream dari controller, yang merupakan aliran data yang akan digunakan untuk menerima nilai.

4. Listen Stream: Memasang listener pada stream menggunakan listen(). Setiap kali ada data baru di stream:

- Callback function akan dipanggil dengan nilai baru (event)
- Memanggil setState() untuk memperbarui UI
- Menyimpan nilai baru ke dalam lastNumber

5. Memanggil super.initState(): Menjalankan implementasi initState() dari kelas induk.

```dart
//Langkah 10
void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    numberStream.addNumberToSink(myNum);
  }
```

#### Penjelasan

1. Membuat Random Object: Membuat instance dari Random untuk menghasilkan angka acak.

2. Menghasilkan Angka Acak: Menggunakan random.nextInt(10) untuk mendapatkan angka acak antara 0-9.

3. Menambahkan ke Stream: Memanggil method addNumberToSink() dari numberStream dengan angka acak yang dihasilkan.

#### Demo

![Capture no 6](/images/captureno6.gif)
