# PathEarn App

PathEarn adalah aplikasi mobile pembelajaran yang dirancang untuk membantu pengguna mengakses kursus, mengikuti kuis, dan mengelola profil pribadi mereka. Aplikasi ini dibangun menggunakan Flutter dan menyediakan pengalaman pengguna yang intuitif dengan fitur-fitur pembelajaran yang komprehensif.

## 📋 Daftar Fitur Aplikasi

### 1. **Autentikasi & Manajemen Pengguna**

- Registrasi akun baru
- Login dengan email dan password
- Logout pengguna
- Session management dengan idle timer
- Autentikasi melalui Supabase

### 2. **Dashboard & Home**

- Tampilan dashboard
- Navigasi mudah ke berbagai fitur aplikasi
- Carousel banner promosi dan informasi penting

### 3. **Learning Management System (LMS)**

- Akses ke daftar kursus pembelajaran
- Menampilkan material pembelajaran
- Pelacakan progress pembelajaran pengguna
- Dukungan konten multimedia (teks, gambar, video)
- Viewer PDF terintegrasi untuk materi learning

### 4. **Quiz & Penilaian**

- Mengikuti berbagai kuis pembelajaran
- Sistem penilaian otomatis
- Menampilkan hasil dan skor kuis

### 5. **Manajemen Data Pribadi**

- Melihat dan mengedit profil pengguna
- Menyimpan informasi pribadi

### 6. **Fitur Premium**

- Akses konten premium eksklusif

### 7. **Fitur Pendukung**

- Pembuka link eksternal (URL Launcher)
- Pemilih file untuk upload materi
- Carousel slider untuk presentasi konten

---

## 🛠️ Tech Stack

### **Frontend Framework**

- **Flutter** (SDK ^3.8.1) - Framework cross-platform untuk pengembangan mobile

### **State Management & Routing**

- **GetX** (^4.7.3) - State management, routing, dan dependency injection

  **GetX digunakan untuk:**
  - **Reactive State Management** - Mengupdate UI secara otomatis ketika state berubah
  - **Route Navigation** - Navigasi antar halaman dengan routing yang powerful

### **Backend & Database**

- **Supabase** (^2.12.0) - Backend-as-a-Service dengan PostgreSQL, autentikasi, dan real-time database

### **UI & Design**

- **Google Fonts** (^6.3.2) - Akses ke library font Google
- **Flutter SVG** (^2.0.9) - Render dan manipulasi file SVG
- **Carousel Slider** (^5.0.0) - Komponen carousel untuk slider gambar
- **Loading Animation Widget** (^1.2.1) - Animasi loading yang menarik

### **Development Tools**

- **Flutter Native Splash** (^2.4.7) - Konfigurasi splash screen
- **Flutter Launcher Icons** - Konfigurasi icon aplikasi

---

## 🏗️ Arsitektur Aplikasi

Aplikasi ini menerapkan **Clean Architecture** dengan struktur folder yang terorganisir:

```
lib/
├── main.dart                 # Entry point aplikasi
├── core/                     # Kode yang bisa digunakan di seluruh aplikasi
│   ├── constants/           # Konstanta global
│   ├── themes/              # Tema aplikasi (light & dark)
│   └── widgets/             # Widget reusable
├── features/                # Fitur utama aplikasi
│   ├── auth/                # Feature autentikasi
│   │   ├── data/           # Data layer (services, repositories)
│   │   └── presentation/   # UI layer (screens, controllers)
│   ├── home/               # Feature dashboard
│   │   ├── data/
│   │   └── presentation/
│   ├── lms/                # Feature Learning Management System
│   │   ├── data/
│   │   └── presentation/
│   ├── personal-data/      # Feature data pribadi pengguna
│   │   ├── data/
│   │   └── presentation/
│   ├── premium/            # Feature premium
│   │   ├── data/
│   │   └── presentation/
│   └── quiz/               # Feature kuis
│       └── presentation/
└── routes/                 # Route management dengan GetX

```

### **Lapisan Arsitektur:**

1. **Data Layer** (`data/`)
   - Repository pattern untuk mengakses data
   - Services untuk komunikasi API dengan Supabase
   - Model data

2. **Presentation Layer** (`presentation/`)
   - Screens/Pages (UI)
   - Controllers (Business Logic dengan GetX)
     - Menggunakan `GetxController` untuk state management
     - Reactive variables dengan `Rx<T>()` atau shorthand `.obs`
     - Observer dengan `Obx()` untuk update UI otomatis
   - Widgets reusable

3. **Core Layer** (`core/`)
   - Themes dan styling global
   - Custom widgets
   - Constants dan utilities

---

## 📱 Cakupan Platform

### Supported Platforms

- **Android** ✅ (Version: min SDK 21)

### Development Status

> ℹ️ **Catatan:** Aplikasi saat ini hanya di-test dan di-develop pada platform Android. Testing di platform lain (iOS, Web, Windows, macOS, Linux) belum dilakukan.

### Persyaratan Sistem

- **Flutter SDK:** ^3.8.1
- **Dart:** Kompatibel dengan Flutter SDK yang ditentukan
- **Android Studio** atau editor lainnya yang support Flutter

---

## 🚀 Cara Menjalankan Aplikasi

### Prerequisites

Sebelum menjalankan aplikasi, pastikan sudah menginstal:

1. **Flutter SDK**
   - Download dari [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
   - Versi yang dibutuhkan: ^3.8.1

2. **Android Studio** (atau IDE lainnya yang support Flutter)
   - Download dari [https://developer.android.com/studio](https://developer.android.com/studio)
   - Setup Android SDK dan emulator

3. **Git** (untuk version control)

### Tahapan Menjalankan Program

#### **Step 1: Clone Repository**

```bash
git clone <repository-url>
cd Raion-Intern-PathEarn
```

#### **Step 2: Download Dependencies**

Download semua package yang diperlukan aplikasi:

```bash
flutter pub get
```

Perintah ini akan membaca `pubspec.yaml` dan mengunduh semua dependency yang tercantum.

#### **Step 3: Verifikasi Konfigurasi (Optional)**

Untuk melihat device yang tersedia:

```bash
flutter devices
```

#### \*\*Step 4: Run Aplikasi di Android

**Opsi 1: Debug Mode (Development)**

```bash
flutter run
```

Aplikasi akan dijalankan dalam mode debug dengan hot reload enabled.

**Opsi 2: Release Mode (Production)**

```bash
flutter run --release
```

Aplikasi berjalan lebih cepat tetapi tanpa debugging tools.

#### **Step 5: Build APK (Optional)**

Untuk membuat file APK yang bisa didistribusikan:

**Debug APK:**

```bash
flutter build apk
```

**Release APK:**

```bash
flutter build apk --release
```

File APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

### Troubleshooting

**Masalah:** Gradle build error

```bash
# Solusi: Jalankan clean build
flutter clean
flutter pub get
flutter run
```

**Masalah:** Device tidak terdeteksi

```bash
# Solusi: Aktifkan USB Debugging di Android device
# Kemudian:
flutter devices  # Verifikasi device
flutter run      # Jalankan ulang
```

**Masalah:** Gradle outdated

```bash
# Solusi: Update Gradle
adb kill-server
adb start-server
```

---

## 📚 Referensi

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Supabase Flutter Documentation](https://supabase.com/docs/reference/flutter)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
