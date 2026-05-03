import 'package:flutter/material.dart';

class AdminOperatingHoursScreen extends StatefulWidget {
  const AdminOperatingHoursScreen({super.key});
  @override
  State<AdminOperatingHoursScreen> createState() => _AdminOperatingHoursScreenState();
}

class _AdminOperatingHoursScreenState extends State<AdminOperatingHoursScreen> {
  TimeOfDay _weekdayOpen = const TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _weekdayClose = const TimeOfDay(hour: 21, minute: 0);
  TimeOfDay _weekendOpen = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _weekendClose = const TimeOfDay(hour: 20, minute: 0);
  bool _weekendEnabled = true;

  String _fmt(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    return '$h:${t.minute.toString().padLeft(2, '0')} ${t.period == DayPeriod.am ? 'AM' : 'PM'}';
  }

  Future<TimeOfDay?> _pick(TimeOfDay init) => showTimePicker(
    context: context, initialTime: init,
    builder: (c, w) => Theme(data: Theme.of(c).copyWith(colorScheme: Theme.of(c).colorScheme.copyWith(primary: const Color(0xFF3B82F6))), child: w!),
  );

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 18), SizedBox(width: 10), Text('Operating hours saved', style: TextStyle(fontWeight: FontWeight.w600))]),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _header(),
          const SizedBox(height: 16),
          _card('Weekday Hours', 'Monday – Friday', Icons.work_rounded, const Color(0xFF3B82F6), [
            _timePair('Opens', _weekdayOpen, (t) => setState(() => _weekdayOpen = t), 'Closes', _weekdayClose, (t) => setState(() => _weekdayClose = t)),
            const SizedBox(height: 14),
            _infoTile('Total Hours', '${(_weekdayClose.hour - _weekdayOpen.hour)}h ${(_weekdayClose.minute - _weekdayOpen.minute).abs()}m'),
          ]),
          const SizedBox(height: 14),
          _card('Weekend Hours', 'Saturday – Sunday', Icons.weekend_rounded, const Color(0xFF8B5CF6), [
            Row(children: [
              const Expanded(child: Text('Enable Weekend', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
              Switch.adaptive(value: _weekendEnabled, onChanged: (v) => setState(() => _weekendEnabled = v), activeColor: const Color(0xFF8B5CF6)),
            ]),
            if (_weekendEnabled) ...[
              const SizedBox(height: 10),
              _timePair('Opens', _weekendOpen, (t) => setState(() => _weekendOpen = t), 'Closes', _weekendClose, (t) => setState(() => _weekendClose = t)),
            ],
          ]),
          const SizedBox(height: 14),
          _card('Quick Presets', 'Tap to apply', Icons.flash_on_rounded, const Color(0xFFF59E0B), [
            Wrap(spacing: 8, runSpacing: 8, children: [
              _preset('Standard', '7:30 AM – 9:00 PM'),
              _preset('Extended', '6:00 AM – 10:00 PM'),
              _preset('Reduced', '8:00 AM – 8:00 PM'),
            ]),
          ]),
          const SizedBox(height: 20),
          _saveBtn(),
          const SizedBox(height: 32),
        ]),
      )),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: Container(width: 38, height: 38,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF0F172A)))),
      const SizedBox(width: 12),
      const Icon(Icons.access_time_rounded, color: Color(0xFF0F172A), size: 24),
      const SizedBox(width: 8),
      const Text('Operating Hours', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
    ]),
  );

  Widget _card(String title, String sub, IconData icon, Color color, List<Widget> children) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
        ]),
      ]),
      const SizedBox(height: 16),
      ...children,
    ]),
  );

  Widget _timePair(String l1, TimeOfDay t1, ValueChanged<TimeOfDay> c1, String l2, TimeOfDay t2, ValueChanged<TimeOfDay> c2) => Row(children: [
    Expanded(child: _timeTile(l1, t1, c1)),
    const SizedBox(width: 12),
    Container(width: 20, height: 2, color: const Color(0xFFE2E8F0)),
    const SizedBox(width: 12),
    Expanded(child: _timeTile(l2, t2, c2)),
  ]);

  Widget _timeTile(String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) => GestureDetector(
    onTap: () async { final p = await _pick(time); if (p != null) onChanged(p); },
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Row(children: [
          Text(_fmt(time), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const Spacer(),
          const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF94A3B8)),
        ]),
      ])),
  );

  Widget _infoTile(String label, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)),
    child: Row(children: [
      const Icon(Icons.info_outline, size: 16, color: Color(0xFF3B82F6)),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
      const Spacer(),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF3B82F6))),
    ]),
  );

  Widget _preset(String label, String desc) => GestureDetector(
    onTap: () {
      if (label == 'Standard') setState(() { _weekdayOpen = const TimeOfDay(hour: 7, minute: 30); _weekdayClose = const TimeOfDay(hour: 21, minute: 0); });
      if (label == 'Extended') setState(() { _weekdayOpen = const TimeOfDay(hour: 6, minute: 0); _weekdayClose = const TimeOfDay(hour: 22, minute: 0); });
      if (label == 'Reduced') setState(() { _weekdayOpen = const TimeOfDay(hour: 8, minute: 0); _weekdayClose = const TimeOfDay(hour: 20, minute: 0); });
    },
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
        Text(desc, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
      ])),
  );

  Widget _saveBtn() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GestureDetector(onTap: _save, child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(14)),
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.save_rounded, color: Colors.white, size: 18), SizedBox(width: 10),
        Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
      ]))),
  );
}
