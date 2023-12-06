import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> sorular = [
    'Flutter nedir?',
    'Dart programlama dili hangi şirket tarafından geliştirilmiştir?',
    'Flutter hot reload nedir?',
  ];

  List<String> dogruCevaplar = ['Google tarafından geliştirilen bir UI toolkit', 'Google', 'Anında kodu güncelleme özelliği'];

  List<String> kullaniciCevaplar = [];

  int soruIndex = 0;

  TextEditingController cevapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Uygulaması'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              sorular[soruIndex],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cevapController,
              decoration: InputDecoration(labelText: 'Cevabınızı yazın'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                kontrolEt();
              },
              child: Text('Cevabı Kontrol Et'),
            ),
          ],
        ),
      ),
    );
  }

  void kontrolEt() {
    String kullaniciCevap = cevapController.text;

    if (kullaniciCevap.isNotEmpty) {
      kullaniciCevaplar.add(kullaniciCevap);

      if (kullaniciCevap == dogruCevaplar[soruIndex]) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tebrikler!'),
              content: Text('Doğru cevap!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    sonrakiSoru();
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Üzgünüm'),
              content: Text('Yanlış cevap. Doğru cevap: ${dogruCevaplar[soruIndex]}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    sonrakiSoru();
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Lütfen bir cevap yazın.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  void sonrakiSoru() {
    cevapController.clear();
    setState(() {
      if (soruIndex < sorular.length - 1) {
        soruIndex++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Tamamlandı'),
              content: Text('Tebrikler, quiz tamamlandı!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
