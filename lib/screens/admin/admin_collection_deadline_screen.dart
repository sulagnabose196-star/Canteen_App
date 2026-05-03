import 'package:flutter/material.dart';

class AdminCollectionDeadlineScreen extends StatefulWidget {
  const AdminCollectionDeadlineScreen({super.key});
  @override
  State<AdminCollectionDeadlineScreen> createState() => _State();
}

class _State extends State<AdminCollectionDeadlineScreen> {
  int _defaultMin = 30;
  int _breakfastMin = 30;
  int _lunchMin = 30;
  int _snacksMin = 20;
  int _dinnerMin = 30;
  bool _perMealCustom = false;
  bool _sendReminder = true;
  int _reminderBefore = 10;

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 18), SizedBox(width: 10), Text('Deadline settings saved')]),
      backgroundColor: const Color(0xFF22C55E), behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.all(16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          _hdr(), const SizedBox(height: 16),
          _section('Default Deadline', 'Time after slot to collect', Icons.timer_outlined, const Color(0xFF10B981), [
            Wrap(spacing: 8, runSpacing: 8, children: [15,20,30,45,60].map((m) => _sel('$m min', _defaultMin==m, ()=>setState(()=>_defaultMin=m))).toList()),
            const SizedBox(height: 12),
            _info('Students must collect within $_defaultMin minutes after their slot ends.'),
          ]),
          const SizedBox(height: 14),
          _section('Per-Meal Customization', 'Set different deadlines per meal', Icons.tune_rounded, const Color(0xFF8B5CF6), [
            Row(children: [
              const Expanded(child: Text('Custom per meal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
              Switch.adaptive(value: _perMealCustom, onChanged: (v)=>setState(()=>_perMealCustom=v), activeColor: const Color(0xFF8B5CF6)),
            ]),
            if (_perMealCustom) ...[
              const SizedBox(height: 12),
              _mealRow('Breakfast', Icons.free_breakfast_rounded, const Color(0xFF3B82F6), _breakfastMin, (v)=>setState(()=>_breakfastMin=v)),
              const SizedBox(height: 10),
              _mealRow('Lunch', Icons.lunch_dining_rounded, const Color(0xFF8B5CF6), _lunchMin, (v)=>setState(()=>_lunchMin=v)),
              const SizedBox(height: 10),
              _mealRow('Snacks', Icons.cookie_rounded, const Color(0xFFF59E0B), _snacksMin, (v)=>setState(()=>_snacksMin=v)),
              const SizedBox(height: 10),
              _mealRow('Dinner', Icons.dinner_dining_rounded, const Color(0xFF10B981), _dinnerMin, (v)=>setState(()=>_dinnerMin=v)),
            ],
          ]),
          const SizedBox(height: 14),
          _section('Reminders', 'Notify before deadline', Icons.notifications_active_outlined, const Color(0xFFF59E0B), [
            Row(children: [
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Send Reminder', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                Text('Push notification before deadline', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              ])),
              Switch.adaptive(value: _sendReminder, onChanged: (v)=>setState(()=>_sendReminder=v), activeColor: const Color(0xFFF59E0B)),
            ]),
            if (_sendReminder) ...[
              const SizedBox(height: 12),
              const Text('Remind before', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [5,10,15,20].map((m) => _sel('$m min', _reminderBefore==m, ()=>setState(()=>_reminderBefore=m))).toList()),
            ],
          ]),
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: GestureDetector(onTap: _save,
            child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(14)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.save_rounded, color: Colors.white, size: 18), SizedBox(width: 10),
                Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              ])))),
          const SizedBox(height: 32),
        ]),
      )),
    );
  }

  Widget _hdr() => Padding(padding: const EdgeInsets.fromLTRB(20,16,20,0), child: Row(children: [
    GestureDetector(onTap: ()=>Navigator.pop(context), child: Container(width: 38, height: 38,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF0F172A)))),
    const SizedBox(width: 12),
    const Icon(Icons.timer_outlined, color: Color(0xFF0F172A), size: 24),
    const SizedBox(width: 8),
    const Text('Collection Deadline', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
  ]));

  Widget _section(String t, String s, IconData ic, Color c, List<Widget> ch) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0,2))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(ic, color: c, size: 18)),
        const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          Text(s, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
        ]))]),
      const SizedBox(height: 16), ...ch,
    ]),
  );

  Widget _sel(String l, bool s, VoidCallback f) => GestureDetector(onTap: f, child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(color: s ? const Color(0xFF0F172A) : Colors.white, borderRadius: BorderRadius.circular(10),
      border: Border.all(color: s ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0))),
    child: Text(l, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: s ? Colors.white : const Color(0xFF0F172A)))));

  Widget _info(String t) => Container(padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)),
    child: Row(children: [const Icon(Icons.info_outline, size: 16, color: Color(0xFF3B82F6)), const SizedBox(width: 8),
      Expanded(child: Text(t, style: const TextStyle(fontSize: 12, color: Color(0xFF3B82F6), fontWeight: FontWeight.w500)))]));

  Widget _mealRow(String name, IconData ic, Color c, int min, ValueChanged<int> onChanged) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
    child: Row(children: [
      Icon(ic, color: c, size: 18), const SizedBox(width: 10),
      Expanded(child: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
      GestureDetector(onTap: (){ if(min>5) onChanged(min-5); }, child: Container(width: 28, height: 28,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Icon(Icons.remove, size: 14, color: Color(0xFF0F172A)))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('$min min', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)))),
      GestureDetector(onTap: ()=>onChanged(min+5), child: Container(width: 28, height: 28,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Icon(Icons.add, size: 14, color: Color(0xFF0F172A)))),
    ]),
  );
}
