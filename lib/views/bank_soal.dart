import 'dart:math';

List<Map<String, dynamic>> bankSoal = [
  {
    "question": "a",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 1,
    "category": "basic",
    "mode": "2x2"
  },
  {
    "question": "Mana jawaban yang benar?",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 1,
    "category": "basic",
    "mode": "2x2"
  },
  {
    "question": "a",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 1,
    "category": "basic",
    "mode": "2x2"
  },
  {
    "question": "b",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 1,
    "category": "basic",
    "mode": "2x2"
  },
  {
    "question": "a",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 1,
    "category": "basic",
    "mode": "1x4"
  },
  {
    "question": "b",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 1,
    "category": "basic",
    "mode": "1x4"
  },
  {
    "question": "c",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 2,
    "category": "advanced",
    "mode": "2x2"
  },
  {
    "question": "d",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 2,
    "category": "advanced",
    "mode": "2x2"
  },
  {
    "question": "e",
    "options": ["ᮃ", "ᮇ", "ᮏ", "ᮜ"],
    "answer": "ᮃ",
    "level": 3,
    "category": "expert",
    "mode": "1x4"
  },
  {
    "question": "f",
    "options": ["ᮄ", "ᮃ", "ᮜ", "ᮇ"],
    "answer": "ᮄ",
    "level": 3,
    "category": "expert",
    "mode": "1x4"
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
