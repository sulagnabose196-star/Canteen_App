import 'package:flutter/material.dart';

class AdminMaxCapacityScreen extends StatefulWidget {
  const AdminMaxCapacityScreen({super.key});
  @override
  State<AdminMaxCapacityScreen> createState() => _State();
}

class _State extends State<AdminMaxCapacityScreen> {
  int _totalCapacity = 1240;
  int _breakfastCap = 1240;
  int _lunchCap = 1240;
  int _snacksCap = 800;
  int _dinnerCap = 1100;
  bool _perMealCustom = false;
  bool _waitlist = true;
  int _waitlistMax = 50;

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 18), SizedBox(width: 10), Text('Capacity settings saved')]),
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
          _section('Total Capacity', 'Maximum students per slot', Icons.groups_rounded, const Color(0xFFF59E0B), [
            Row(children: [
              _cBtn(Icons.remove, (){ if(_totalCapacity>100) setState(()=>_totalCapacity-=10); }),
              Expanded(child: Center(child: Text('$_totalCapacity', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))))),
              _cBtn(Icons.add, ()=>setState(()=>_totalCapacity+=10)),
            ]),
            const SizedBox(height: 6),
            const Center(child: Text('students', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500))),
            const SizedBox(height: 14),
            Wrap(spacing: 8, runSpacing: 8, children: [500,800,1000,1240,1500].map((v) => _sel('$v', _totalCapacity==v, ()=>setState(()=>_totalCapacity=v))).toList()),
          ]),
          const SizedBox(height: 14),
          _section('Per-Meal Limits', 'Custom cap per meal', Icons.tune_rounded, const Color(0xFF8B5CF6), [
            Row(children: [
              const Expanded(child: Text('Enable per-meal limits', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
              Switch.adaptive(value: _perMealCustom, onChanged: (v)=>setState(()=>_perMealCustom=v), activeColor: const Color(0xFF8B5CF6)),
            ]),
            if (_perMealCustom) ...[
              const SizedBox(height: 12),
              _mealCap('Breakfast', Icons.free_breakfast_rounded, const Color(0xFF3B82F6), _breakfastCap, (v)=>setState(()=>_breakfastCap=v)),
              const SizedBox(height: 10),
              _mealCap('Lunch', Icons.lunch_dining_rounded, const Color(0xFF8B5CF6), _lunchCap, (v)=>setState(()=>_lunchCap=v)),
              const SizedBox(height: 10),
              _mealCap('Snacks', Icons.cookie_rounded, const Color(0xFFF59E0B), _snacksCap, (v)=>setState(()=>_snacksCap=v)),
              const SizedBox(height: 10),
              _mealCap('Dinner', Icons.dinner_dining_rounded, const Color(0xFF10B981), _dinnerCap, (v)=>setState(()=>_dinnerCap=v)),
            ],
          ]),
          const SizedBox(height: 14),
          _section('Waitlist', 'Overflow handling', Icons.queue_rounded, const Color(0xFF10B981), [
            Row(children: [
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Enable Waitlist', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                Text('Queue students when full', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              ])),
              Switch.adaptive(value: _waitlist, onChanged: (v)=>setState(()=>_waitlist=v), activeColor: const Color(0xFF10B981)),
            ]),
            if (_waitlist) ...[
              const SizedBox(height: 12),
              Row(children: [
                const Text('Max waitlist size', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                const Spacer(),
                _cBtn(Icons.remove, (){ if(_waitlistMax>10) setState(()=>_waitlistMax-=10); }),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text('$_waitlistMax', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)))),
                _cBtn(Icons.add, ()=>setState(()=>_waitlistMax+=10)),
              ]),
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
    const Icon(Icons.groups_rounded, color: Color(0xFF0F172A), size: 24),
    const SizedBox(width: 8),
    const Text('Max Capacity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
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
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(color: s ? const Color(0xFF0F172A) : Colors.white, borderRadius: BorderRadius.circular(10),
      border: Border.all(color: s ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0))),
    child: Text(l, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: s ? Colors.white : const Color(0xFF0F172A)))));

  Widget _cBtn(IconData ic, VoidCallback f) => GestureDetector(onTap: f, child: Container(width: 40, height: 40,
    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
    child: Icon(ic, size: 18, color: const Color(0xFF0F172A))));

  Widget _mealCap(String name, IconData ic, Color c, int cap, ValueChanged<int> onChange) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
    child: Row(children: [
      Icon(ic, color: c, size: 18), const SizedBox(width: 10),
      Expanded(child: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
      GestureDetector(onTap: (){ if(cap>100) onChange(cap-50); }, child: Container(width: 28, height: 28,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Icon(Icons.remove, size: 14, color: Color(0xFF0F172A)))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('$cap', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)))),
      GestureDetector(onTap: ()=>onChange(cap+50), child: Container(width: 28, height: 28,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Icon(Icons.add, size: 14, color: Color(0xFF0F172A)))),
    ]),
  );
}
