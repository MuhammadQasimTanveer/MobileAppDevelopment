import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class Flashcard {
  final String id, question, answer;
  bool learned;
  Flashcard({required this.id, required this.question, required this.answer, this.learned = false});
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Flashcard> _cards = [];
  int _idCounter = 0;

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  void _generateCards() => _cards = List.generate(
    5,
        (i) => Flashcard(id: '${_idCounter++}', question: 'Question ${i + 1}?', answer: 'Answer ${i + 1}'),
  );

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _cards.forEach((c) => c.learned = false));
  }

  void _addCard(String q, String a) {
    final newCard = Flashcard(id: '${_idCounter++}', question: q, answer: a);
    _cards.insert(0, newCard);
    _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _showAddDialog() {
    final qCtrl = TextEditingController(), aCtrl = TextEditingController(), fKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Card'),
        content: Form(
          key: fKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: qCtrl, decoration: const InputDecoration(labelText: 'Question'), validator: (v) => v!.trim().isEmpty ? 'Enter question' : null),
              const SizedBox(height: 8),
              TextFormField(controller: aCtrl, decoration: const InputDecoration(labelText: 'Answer'), validator: (v) => v!.trim().isEmpty ? 'Enter answer' : null),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (fKey.currentState!.validate()) {
                _addCard(qCtrl.text.trim(), aCtrl.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  int get _learned => _cards.where((c) => c.learned).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _showAddDialog, child: const Icon(Icons.add)),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Learned: $_learned / ${_cards.length}'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: _cards.isEmpty
                  ? SliverFillRemaining(
                  child: Center(child: Text('All cards learned!\nPull down to refresh', textAlign: TextAlign.center)))
                  : SliverAnimatedList(
                key: _listKey,
                initialItemCount: _cards.length,
                itemBuilder: (context, index, anim) {
                  final card = _cards[index];
                  return SizeTransition(
                    sizeFactor: anim,
                    child: FlashcardItem(
                      flashcard: card,
                      onDismissed: () {
                        setState(() => card.learned = true);
                        _cards.removeAt(index);
                        _listKey.currentState?.removeItem(index,
                                (context, animation) => FlashcardItem(flashcard: card, onDismissed: () {}));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlashcardItem extends StatefulWidget {
  final Flashcard flashcard;
  final VoidCallback onDismissed;
  const FlashcardItem({super.key, required this.flashcard, required this.onDismissed});

  @override
  State<FlashcardItem> createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<FlashcardItem> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.flashcard.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismissed(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.check, color: Colors.white, size: 32),
      ),
      child: GestureDetector(
        onTap: () => setState(() => _showAnswer = !_showAnswer),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.flashcard.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(widget.flashcard.answer, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                crossFadeState: _showAnswer ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              )
            ],
          ),
        ),
      ),
    );
  }
}