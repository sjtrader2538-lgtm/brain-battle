
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const BrainBattleApp());

class Question {
  final String question;
  final List<String> answers;
  final int correct;
  const Question(this.question, this.answers, this.correct);
}

const questionBank = <String, List<Question>>{
  'General Knowledge': [
    Question('What is the capital of Pakistan?', ['Lahore','Islamabad','Karachi','Multan'], 1),
    Question('How many continents are there?', ['5','6','7','8'], 2),
    Question('Which is the largest ocean?', ['Atlantic','Indian','Pacific','Arctic'], 2),
    Question('Which country is famous for the Eiffel Tower?', ['Italy','France','Spain','Germany'], 1),
    Question('How many days are in a leap year?', ['364','365','366','367'], 2),
  ],
  'Science': [
    Question('Which planet is known as the Red Planet?', ['Earth','Mars','Venus','Jupiter'], 1),
    Question('What gas do humans need to breathe?', ['Oxygen','Carbon dioxide','Hydrogen','Helium'], 0),
    Question('What is H2O?', ['Oxygen','Water','Hydrogen','Salt'], 1),
    Question('What force pulls objects toward Earth?', ['Magnetism','Gravity','Friction','Pressure'], 1),
    Question('Which organ pumps blood?', ['Lungs','Brain','Heart','Liver'], 2),
  ],
  'Mathematics': [
    Question('What is 5 × 5?', ['15','20','25','30'], 2),
    Question('What is 100 ÷ 10?', ['5','10','20','25'], 1),
    Question('What is 12 + 8?', ['18','20','22','24'], 1),
    Question('What is 9 × 7?', ['54','63','72','81'], 1),
    Question('What is 50% of 80?', ['20','30','40','50'], 2),
  ],
  'Computer': [
    Question('What does CPU stand for?', ['Central Processing Unit','Computer Personal Unit','Central Program Utility','Control Processing User'], 0),
    Question('Which language is used to build Flutter apps?', ['Java','Dart','Python','C++'], 1),
    Question('Which device moves the pointer?', ['Keyboard','Monitor','Mouse','Printer'], 2),
    Question('What does RAM stand for?', ['Random Access Memory','Read Access Machine','Rapid Application Module','Random App Manager'], 0),
    Question('Which one is an operating system?', ['Python','Android','HTML','Flutter'], 1),
  ],
  'Sports': [
    Question('How many players are on a football team on the field?', ['9','10','11','12'], 2),
    Question('Which sport uses a bat and ball?', ['Swimming','Cricket','Boxing','Tennis'], 1),
    Question('How many rings are on the Olympic symbol?', ['4','5','6','7'], 1),
    Question('How many players are on a cricket team?', ['9','10','11','12'], 2),
    Question('Which sport uses a racket?', ['Football','Tennis','Boxing','Swimming'], 1),
  ],
};

class BrainBattleApp extends StatelessWidget {
  const BrainBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brain Battle',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090B14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C4DFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7C4DFF).withOpacity(.15),
              border: Border.all(color: const Color(0xFF7C4DFF), width: 2),
            ),
            child: const Icon(Icons.psychology, size: 80, color: Color(0xFFB388FF)),
          ),
          const SizedBox(height: 24),
          const Text('BRAIN BATTLE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const SizedBox(height: 8),
          const Text('Think Fast. Battle Smart.', style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 35),
          const CircularProgressIndicator(),
        ],
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int xp = 0;
  int level = 1;
  int coins = 0;

  void reward(int earnedXp, int earnedCoins) {
    setState(() {
      xp += earnedXp;
      coins += earnedCoins;
      while (xp >= 500) {
        xp -= 500;
        level++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = xp / 500;
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧠 Brain Battle', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => ProfileScreen(level: level, xp: xp, coins: coins),
            )),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gradientCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Welcome, Player 👋', style: TextStyle(fontSize: 17)),
                const SizedBox(height: 8),
                Text('Level $level', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(value: progress, minHeight: 9),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('$xp / 500 XP'), Text('🪙 $coins')],
                ),
              ]),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity, height: 62,
              child: FilledButton.icon(
                icon: const Icon(Icons.flash_on),
                label: const Text('QUICK BATTLE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                onPressed: () => _openCategories(context),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questionBank.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.35,
              ),
              itemBuilder: (_, i) {
                final category = questionBank.keys.elementAt(i);
                return CategoryCard(
                  title: category,
                  icon: _categoryIcon(category),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => QuizScreen(category: category, reward: reward),
                  )),
                );
              },
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.leaderboard, color: Colors.amber),
                title: const Text('Leaderboard', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('See the top players'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaderboardScreen())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCategories(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(reward: reward)));
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Science': return Icons.science;
      case 'Mathematics': return Icons.calculate;
      case 'Computer': return Icons.computer;
      case 'Sports': return Icons.sports_soccer;
      default: return Icons.public;
    }
  }

  Widget _gradientCard({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)]),
      borderRadius: BorderRadius.circular(22),
    ),
    child: child,
  );
}

class CategoryScreen extends StatelessWidget {
  final void Function(int, int) reward;
  const CategoryScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Choose Category')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: questionBank.keys.map((category) => Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          leading: const CircleAvatar(child: Icon(Icons.psychology)),
          title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${questionBank[category]!.length} questions'),
          trailing: const Icon(Icons.play_arrow),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => QuizScreen(category: category, reward: reward),
          )),
        ),
      )).toList(),
    ),
  );
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const CategoryCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(18),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.055),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: const Color(0xFFB388FF)),
          const SizedBox(height: 9),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

class QuizScreen extends StatefulWidget {
  final String category;
  final void Function(int, int) reward;
  const QuizScreen({super.key, required this.category, required this.reward});
  @override State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<Question> quizQuestions;
  Timer? timer;
  int current = 0;
  int timeLeft = 10;
  int score = 0;
  int correct = 0;
  bool locked = false;

  @override
  void initState() {
    super.initState();
    quizQuestions = List.of(questionBank[widget.category]!);
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timeLeft = 10;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (timeLeft <= 1) {
        timer?.cancel();
        setState(() => timeLeft = 0);
        _nextQuestion();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void _answer(int selected) {
    if (locked) return;
    locked = true;
    timer?.cancel();
    final q = quizQuestions[current];
    if (selected == q.correct) {
      score += 100 + timeLeft * 10;
      correct++;
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    if (!mounted) return;
    if (current < quizQuestions.length - 1) {
      setState(() {
        current++;
        locked = false;
      });
      _startTimer();
    } else {
      final earnedXp = correct * 25;
      final earnedCoins = correct * 5;
      widget.reward(earnedXp, earnedCoins);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: score, correct: correct, total: quizQuestions.length,
          xp: earnedXp, coins: earnedCoins,
        ),
      ));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = quizQuestions[current];
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${current + 1}/${quizQuestions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: timeLeft <= 3 ? Colors.red.shade700 : Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('⏱ $timeLeft', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 22),
            LinearProgressIndicator(value: timeLeft / 10, minHeight: 5),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.055),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(q.question, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 22),
            ...List.generate(q.answers.length, (i) => Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: SizedBox(
                width: double.infinity, height: 56,
                child: FilledButton.tonal(
                  onPressed: () => _answer(i),
                  child: Text(q.answers[i], style: const TextStyle(fontSize: 16)),
                ),
              ),
            )),
            const Spacer(),
            Text('Score: $score', style: const TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score, correct, total, xp, coins;
  const ResultScreen({super.key, required this.score, required this.correct, required this.total, required this.xp, required this.coins});

  @override
  Widget build(BuildContext context) {
    final accuracy = ((correct / total) * 100).round();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 88, color: Colors.amber),
                const SizedBox(height: 18),
                const Text('BATTLE COMPLETE!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                const SizedBox(height: 18),
                Text('$score', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w900)),
                const Text('SCORE', style: TextStyle(color: Colors.white54)),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ResultStat('Correct', '$correct'),
                    ResultStat('Accuracy', '$accuracy%'),
                    ResultStat('XP', '+$xp'),
                    ResultStat('Coins', '+$coins'),
                  ],
                ),
                const SizedBox(height: 35),
                SizedBox(width: double.infinity, height: 55,
                  child: FilledButton(
                    onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                    child: const Text('BACK TO HOME', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultStat extends StatelessWidget {
  final String title, value;
  const ResultStat(this.title, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
    ],
  );
}

class ProfileScreen extends StatelessWidget {
  final int level, xp, coins;
  const ProfileScreen({super.key, required this.level, required this.xp, required this.coins});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 52, child: Icon(Icons.person, size: 55)),
          const SizedBox(height: 14),
          const Text('Player', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          Text('Level $level', style: const TextStyle(color: Color(0xFFB388FF))),
          const SizedBox(height: 25),
          ProfileStat(Icons.star, 'XP', '$xp'),
          ProfileStat(Icons.monetization_on, 'Coins', '$coins'),
          const ProfileStat(Icons.emoji_events, 'Wins', '0'),
          const ProfileStat(Icons.psychology, 'Questions', '0'),
          const ProfileStat(Icons.local_fire_department, 'Best Streak', '0'),
        ],
      ),
    ),
  );
}

class ProfileStat extends StatelessWidget {
  final IconData icon; final String title, value;
  const ProfileStat(this.icon, this.title, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});
  static const players = [
    ('BrainMaster', 12850),
    ('QuizKing', 11920),
    ('SmartPlayer', 10870),
    ('KnowledgePro', 9650),
    ('You', 8920),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('🏆 Leaderboard')),
    body: ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: players.length,
      itemBuilder: (_, i) => Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${i + 1}')),
          title: Text(players[i].$1, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('${players[i].$2} XP', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );
}
