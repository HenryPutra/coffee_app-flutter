Proyek Coffee App
Ini adalah proyek Flutter yang dikembangkan sebagai tugas onboarding untuk memahami slicing UI, struktur proyek, dan penerapan state management menggunakan GetX.

Cara Instalasi Project
Clone repositori:

git clone https://github.com/nama-pengguna-anda/coffee_app-flutter.git

(Ganti URL dengan URL repositori Anda.)

Masuk ke direktori proyek:

cd coffee_app-flutter

Ambil dependensi:

flutter pub get

Cara Menjalankan Project
Pastikan Anda memiliki emulator Android/iOS yang berjalan atau perangkat fisik yang terhubung.

Jalankan aplikasi dengan perintah:

flutter run

Struktur Folder
Proyek ini mengikuti struktur folder yang rapi dan modular untuk memisahkan UI dari logika bisnis dan navigasi.

lib/app/bindings/: Berisi kelas binding untuk mendaftarkan controller ke dependency injection GetX.

lib/app/controllers/: Berisi semua GetxController yang mengelola logika bisnis dan state.

lib/app/routes/: Mengelola semua rute dan nama rute aplikasi.

lib/app/views/: Berisi semua file tampilan (UI) untuk setiap halaman.

lib/core/constants/: Berisi konstanta yang digunakan di seluruh aplikasi.

lib/core/theme/: Berisi tema dan skema warna aplikasi.

lib/main.dart: Titik masuk utama aplikasi.

Penggunaan GetX di Project Ini
Proyek ini memanfaatkan GetX sebagai state management dan routing untuk membuat aplikasi menjadi reaktif dan mudah dikelola.

Deklarasi Controller: Setiap halaman memiliki controller sendiri (misalnya, HomeController dan DetailController) yang diperluas dari GetxController untuk mengelola state dan logika.

.obs (Observables): Variabel state yang perlu diperbarui secara reaktif dideklarasikan dengan .obs (misalnya, selectedCategoryIndex.obs).

Navigasi: Navigasi antar halaman dilakukan menggunakan metode Get.toNamed() untuk navigasi bernama (misalnya, Get.toNamed(Routes.DETAIL)).

Dependency Injection: Bindings digunakan untuk mendaftarkan controller dengan Get.lazyPut(), memastikan controller dibuat hanya saat dibutuhkan, mengoptimalkan kinerja aplikasi.
