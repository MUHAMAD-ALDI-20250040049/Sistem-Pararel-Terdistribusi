# Laporan Praktikum: Monitoring Data Mahasiswa dengan Java RMI

## Tujuan

Menerapkan komunikasi client-server menggunakan Java RMI dan menghubungkan layanan tersebut ke aplikasi web berbasis Servlet.

## Ringkasan Implementasi

`rmi-common` berisi model `Mahasiswa` yang dapat dikirim melalui RMI dan kontrak `MahasiswaService`. `rmi-server` menjalankan registry pada port 1099 dan mendaftarkan layanan mahasiswa; objek layanan menggunakan port 1100. `rmi-client` mencari layanan melalui registry lalu menampilkan daftar dan jumlah mahasiswa. Aplikasi web menggunakan Servlet sebagai RMI client, menampilkan data dalam tabel, serta menyediakan pencarian berdasarkan NIM, detail, tambah, ubah, dan hapus data.

Data contoh disimpan di memori server, sehingga perubahan akan hilang saat server dimulai ulang. Aplikasi web memerlukan konfigurasi akun administrator melalui environment Tomcat.

## Jawaban Pertanyaan Analisis

### 1. Apa yang dimaksud dengan Remote Method Invocation (RMI)?

Remote Method Invocation (RMI) adalah mekanisme Java untuk memanggil method pada objek yang berjalan di proses atau komputer lain. RMI menangani komunikasi jaringan, pengiriman argumen dan hasil, serta representasi referensi objek remote.

### 2. Apa perbedaan RMI dengan pemanggilan method biasa?

Pemanggilan method biasa terjadi pada objek dalam proses yang sama, sehingga pemanggilan berlangsung langsung di memori. Pada RMI, objek berada di proses atau mesin berbeda; pemanggilan melewati jaringan, data harus dapat diserialisasi, waktu respons dipengaruhi jaringan, dan kegagalan komunikasi dapat menghasilkan `RemoteException`.

### 3. Mengapa RMI membutuhkan RMI Registry?

RMI Registry menyediakan direktori untuk mendaftarkan dan menemukan objek remote dengan nama layanan. Client mencari nama seperti `MahasiswaService` pada registry sehingga tidak perlu membuat sendiri referensi objek server.

### 4. Apa fungsi interface dalam implementasi Java RMI?

Interface mendefinisikan kontrak method yang dapat dipanggil client. Interface layanan memperluas `Remote`, dan setiap method remote mendeklarasikan kemungkinan `RemoteException`. Server menyediakan implementasinya, sementara client memakai interface yang sama untuk berkomunikasi.

### 5. Bagaimana proses komunikasi antara Web Client, RMI Client, dan RMI Server?

Browser mengirim permintaan HTTP ke Servlet. Servlet bertindak sebagai RMI client: mencari `MahasiswaService` di registry, memanggil method server seperti `getAllMahasiswa()` atau `findByNim()`, lalu menerima objek `Mahasiswa` melalui RMI. Servlet menyusun hasil menjadi HTML dan mengirimkannya kembali ke browser. Untuk perubahan data, Servlet meneruskan permintaan tambah, ubah, atau hapus ke layanan remote.

### 6. Apa kelebihan dan kekurangan RMI dibandingkan REST API?

RMI memudahkan komunikasi antaraplikasi Java karena memakai interface dan objek Java secara langsung, mendukung pemanggilan bertipe, serta mengurangi kebutuhan menyusun protokol data sendiri. Kekurangannya, RMI bergantung pada Java, membutuhkan pengaturan registry dan port jaringan, dan integrasinya dengan client lintas bahasa atau web publik tidak semudah REST. REST umumnya lebih interoperabel dan mudah digunakan melalui HTTP, tetapi membutuhkan rancangan endpoint dan format data seperti JSON.

## Kesimpulan

Java RMI memungkinkan aplikasi client mengakses layanan data mahasiswa di server melalui kontrak remote bersama dan RMI Registry. Servlet dapat menjadi penghubung antara browser dan layanan RMI, sehingga data dari server dapat ditampilkan dan dikelola melalui aplikasi web. Keberhasilan komunikasi bergantung pada server yang aktif, alamat host dan port yang benar, serta akses jaringan antara client dan server.

## Bukti Pengujian

Lengkapi bagian ini dengan tangkapan layar setelah aplikasi dijalankan:

1. RMI Server aktif pada registry port 1099 dan service port 1100.
2. RMI Client berhasil terhubung dan menampilkan data mahasiswa.
3. Halaman web menampilkan tabel dan jumlah mahasiswa.
4. Pencarian NIM berhasil serta menampilkan data yang cocok.
5. Tambah/hapus data berhasil dan jumlah mahasiswa diperbarui.
6. Client atau web menampilkan pesan kegagalan saat RMI Server dimatikan.

Build dan pengujian runtime belum dapat dilakukan pada lingkungan penyusunan laporan ini karena Maven belum tersedia.
