import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas2_PM2',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5A00D0),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5A00D0),
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
      ),
      home: ProfilePage(
        onThemeToggle: () {
          setState(() {
            themeMode = themeMode == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
          });
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const ProfilePage({super.key, required this.onThemeToggle});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Muhamad Kosasih';
  String email = 'muhammadkosasih@gmail.com';
  String phone = '083816093005';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 12,
              shadowColor: Colors.black26,
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF5A00D0).withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Color(0xFF5A00D0),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F2B96),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Mahasiswa Informatika',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        buildMenuButton(
                          icon: Icons.person_outline,
                          label: 'Data Diri',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataDiriPage(
                                  name: name,
                                  email: email,
                                  phone: phone,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        buildMenuButton(
                          icon: Icons.edit_outlined,
                          label: 'Ubah Data Diri',
                          onPressed: () {
                            showEditDialog(context);
                          },
                        ),
                        const SizedBox(height: 12),
                        buildMenuButton(
                          icon: Icons.info_outline,
                          label: 'Tentang',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        buildMenuButton(
                          icon: Icons.brightness_6_outlined,
                          label: 'Tema',
                          onPressed: widget.onThemeToggle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF3F2B96),
          side: const BorderSide(color: Color(0xFF3F2B96), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ubah Data Diri'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildTextField('Nama', nameController),
                const SizedBox(height: 10),
                buildTextField('Email', emailController),
                const SizedBox(height: 10),
                buildTextField('Telepon', phoneController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A00D0),
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF5A00D0), width: 2),
        ),
      ),
    );
  }
}

class DataDiriPage extends StatelessWidget {
  final String name, email, phone;
  const DataDiriPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Diri'),
        backgroundColor: const Color(0xFF5A00D0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoTile(Icons.person, name),
            infoTile(Icons.email, email),
            infoTile(Icons.phone, phone),
            infoTile(Icons.location_on, 'Bandung, Indonesia'),
          ],
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF5A00D0)),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: const Color(0xFF5A00D0),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Aplikasi ini dibuat sebagai tugas mata kuliah Pemrograman Mobile 2.\n\n',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
