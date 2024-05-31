import 'dart:math';

List<Map<String, dynamic>> bankSoal = [
  {
    "question": "a",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 1,
    "category": "basic"
  },
  {
    "question": "b",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 1,
    "category": "basic"
  },
  {
    "question": "c",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 2,
    "category": "advanced"
  },
  {
    "question": "d",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 2,
    "category": "advanced"
  },
  {
    "question": "e",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 3,
    "category": "expert"
  },
  {
    "question": "f",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 3,
    "category": "expert"
  },
  // Tambahkan soal lainnya dengan level dan kategori yang sesuai
];

void shuffle(List<Map<String, dynamic>> list) {
  var random = Random();
  for (var i = list.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = list[i];
    list[i] = list[n];
    list[n] = temp;
  }
}

List<Map<String, dynamic>> getLevelQuestions(int level, String category) {
  List<Map<String, dynamic>> filteredQuestions = bankSoal
      .where((question) =>
          question['level'] == level && question['category'] == category)
      .toList();
  shuffle(filteredQuestions);

  if (level == 1) {
    return filteredQuestions.sublist(0, min(10, filteredQuestions.length));
  } else if (level == 2) {
    return filteredQuestions.sublist(0, min(15, filteredQuestions.length));
  } else {
    return filteredQuestions.sublist(0, min(20, filteredQuestions.length));
  }
}
