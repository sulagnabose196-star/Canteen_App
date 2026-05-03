import 'package:flutter/material.dart';

class AdminBookingWindowScreen extends StatefulWidget {
  const AdminBookingWindowScreen({super.key});
  @override
  State<AdminBookingWindowScreen> createState() => _State();
}

class _State extends State<AdminBookingWindowScreen> {
  int _advHrs = 24;
  int _cancelHrs = 2;
  bool _sameDay = true;
  bool _autoConfirm = true;
  int _maxPerDay = 3;

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 18), SizedBox(width: 10), Text('Booking settings saved')]),
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
          _section('Advance Booking', 'How far ahead', Icons.event_note_rounded, const Color(0xFF8B5CF6), [
            Wrap(spacing: 8, runSpacing: 8, children: [6,12,24,48,72].map((h) => _sel('$h hrs', _advHrs==h, () => setState(()=>_advHrs=h))).toList()),
            const SizedBox(height: 12),
            _info('Students can book $_advHrs hours ahead.'),
          ]),
          const SizedBox(height: 14),
          _section('Cancellation', 'Deadline to cancel', Icons.cancel_outlined, const Color(0xFFEF4444), [
            Wrap(spacing: 8, runSpacing: 8, children: [1,2,4,6].map((h) => _sel('$h hrs', _cancelHrs==h, () => setState(()=>_cancelHrs=h))).toList()),
            const SizedBox(height: 12),
            _info('Cancel at least $_cancelHrs hours before slot.'),
          ]),
          const SizedBox(height: 14),
          _section('Rules', 'Additional settings', Icons.rule_rounded, const Color(0xFF10B981), [
            _tog('Same-Day Booking', 'Allow today\'s remaining slots', _sameDay, (v)=>setState(()=>_sameDay=v)),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            _tog('Auto-Confirm', 'Confirm bookings automatically', _autoConfirm, (v)=>setState(()=>_autoConfirm=v)),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            Row(children: [
              const Expanded(child: Text('Max Bookings/Day', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
              _cBtn(Icons.remove, (){ if(_maxPerDay>1) setState(()=>_maxPerDay--); }),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text('$_maxPerDay', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)))),
              _cBtn(Icons.add, ()=>setState(()=>_maxPerDay++)),
            ]),
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
    const Icon(Icons.event_note_rounded, color: Color(0xFF0F172A), size: 24),
    const SizedBox(width: 8),
    const Text('Booking Window', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
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

  Widget _tog(String t, String s, bool v, ValueChanged<bool> f) => Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
      Text(s, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)))])),
    Switch.adaptive(value: v, onChanged: f, activeColor: const Color(0xFF10B981))]);

  Widget _cBtn(IconData ic, VoidCallback f) => GestureDetector(onTap: f, child: Container(width: 32, height: 32,
    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE2E8F0))),
    child: Icon(ic, size: 16, color: const Color(0xFF0F172A))));
}
