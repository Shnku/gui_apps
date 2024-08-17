import 'dart:collection';

final qustionList = [
  {
    'q':
        'How many times does the hour hand and minute hand of a clock coincide in half a day?',
    'a0': 'sadasdasd',
    'a1': 'ahdgajsasdasgd111',
    'a2': 'aaa222222ffkhfjksdhfj with the resfj with the resp',
    'a3': 'weqewqeqweqe',
    'correctAnswer': 'a2', // Specify the correct answer key
    'marks': '',
  },
  {
    'q':
        'A fruit seller has a stock of mangoes, bananas and apples with at least one fruit of each type. At the beginning of a day, the number of mangoes make up 40% of his stock. That day, he sells half of the mangoes, 96 bananas and 40% of the apples. At the end of the day, he ends up selling 50% of the fruits. The smallest possible total number of fruits in the stock at the beginning of the day is',
    'a0': 'sadasdasd',
    'a1': 'ahdgajsasdasgd111',
    'a2': 'aaa222222',
    'a3': 'weqewqeqweqe',
    'correctAnswer': 'a2', // Specify the correct answer key
    'marks': '',
  },
  {
    'q':
        'hsjkfhjkhsjkfhsdjhay fucker how are you the fucking men ashjahjasdcvsadsdhfj',
    'a0': 'sadasdasd',
    'a1': 'fuck off the fucking mouthe of yours asjdhasjkdhadajk',
    'a2': 'aaa222sdfsdfsdfsd222',
    'a3': 'no wharete you gon',
    'correctAnswer': 'a3', // Specify the correct answer key
    'marks': '',
  },
  {
    'q':
        '14 L 280 mL of orange juice and 18 L 830 mL of carrot juice were mixed together. This mixture was filled in 15 bottles L. How much mixture was left ?',
    'a0': '11 L 105 mL',
    'a1': '11 L 105 mL',
    'a2': '1 L 105 mL',
    'a3': '9 L 610 mL',
    'correctAnswer': 'a0', // Specify the correct answer key
    'marks': '',
  }
];

final totalmarks = 5 * qustionList.length;
int gettedMarks = 0;
void evalResult() {
  if (gettedMarks > 0) gettedMarks = 0;
  for (var element in qustionList) {
    print('${element['marks']}\t${element['correctAnswer']}');
    if (element['marks'] == element['correctAnswer']) {
      gettedMarks += 5;
    } else {
      // gettedMarks -= 5;
    }
  }
  print('gettingdata=$gettedMarks');
}
