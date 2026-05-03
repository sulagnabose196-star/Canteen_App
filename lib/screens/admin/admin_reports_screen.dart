import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/admin_charts.dart';
// import 'package:provider/provider.dart';
// import '../../providers/canteen_provider.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  int _periodIndex = 1; // 0=Today, 1=This Week, 2=This Month
  final _periods = ['Today', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildPeriodToggle(),
              const SizedBox(height: 16),
              _buildKPIRow(),
              const SizedBox(height: 20),
              _buildTrendsChart(),
              const SizedBox(height: 20),
              _buildCollectionRate(),
              const SizedBox(height: 20),
              _buildMealBreakdown(),
              const SizedBox(height: 20),
              _buildWasteAnalysis(),
              const SizedBox(height: 20),
              _buildExportButtons(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          // GestureDetector(
          //   onTap: () => context.read<CanteenProvider>().setIndex(0),
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(color: const Color(0xFFE2E8F0)),
          //     ),
          //     child: const Icon(
          //       Icons.arrow_back_ios_new,
          //       size: 16,
          //       color: Color(0xFF0F172A),
          //     ),
          //   ),
          // ),
          const SizedBox(width: 12),
          const Icon(
            Icons.analytics_rounded,
            color: Color(0xFF0F172A),
            size: 24,
          ),
          const SizedBox(width: 10),
          const Text(
            'Reports & Analytics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodToggle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_periods.length, (i) {
          final sel = i == _periodIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _periodIndex = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: sel ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: sel
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    _periods[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: sel
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKPIRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _kpiCard(
              'TOTAL BOOKINGS',
              '6,240',
              Icons.trending_up,
              const Color(0xFF22C55E),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _kpiCard(
              'WASTED MEALS',
              '5,890',
              Icons.trending_down,
              const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpiCard(
    String label,
    String value,
    IconData trend,
    Color trendColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Icon(trend, color: trendColor, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsChart() {
    return _section(
      'Daily Bookings Trends',
      child: Column(
        children: [
          Row(
            children: [
              _legendDot(const Color(0xFF3B82F6), 'Breakfast'),
              const SizedBox(width: 12),
              _legendDot(const Color(0xFF8B5CF6), 'Lunch'),
              const SizedBox(width: 12),
              _legendDot(const Color(0xFF10B981), 'Dinner'),
            ],
          ),
          const SizedBox(height: 16),
          TrendLineChart(
            data: const [820, 950, 780, 1100, 890, 1050, 920],
            labels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            height: 200,
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionRate() {
    return _section(
      'Collection Rate',
      child: Row(
        children: [
          DonutChart(
            percentage: 94.4,
            centerLabel: '94.4%',
            centerSubLabel: 'Collected',
            size: 140,
            segments: const [
              DonutSegment(
                value: 94.4,
                color: Color(0xFF3B82F6),
                label: 'Collected',
              ),
              DonutSegment(
                value: 3.6,
                color: Color(0xFF10B981),
                label: 'Cancelled',
              ),
              DonutSegment(
                value: 2.0,
                color: Color(0xFFE2E8F0),
                label: 'No Show',
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _legendRow(const Color(0xFF3B82F6), 'Collected', '5,890'),
                const SizedBox(height: 10),
                _legendRow(const Color(0xFF10B981), 'Cancelled', '108'),
                const SizedBox(height: 10),
                _legendRow(const Color(0xFFE2E8F0), 'No Show', '102'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendRow(Color color, String label, String val) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          val,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildMealBreakdown() {
    return _section(
      'Meal Breakdown',
      child: Column(
        children: [
          _tableHeader(),
          _tableRow('Breakfast', '1,560', '1,512', '1,782'),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _tableRow('Lunch', '4,830', '1,432', '328'),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _tableRow('Snack', '', '', ''),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _tableRow('Dinner', '1,560', '1,803', '122'),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _tableRow('Total', '6,240', '5,899', '360', bold: true),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              '',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'BOOKED',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'COLLECTED',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'WASTED',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableRow(
    String meal,
    String booked,
    String collected,
    String wasted, {
    bool bold = false,
  }) {
    final style = TextStyle(
      fontSize: 13,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      color: const Color(0xFF0F172A),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(meal, style: style)),
          Expanded(
            child: Text(booked, textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: Text(collected, textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: Text(
              wasted,
              textAlign: TextAlign.center,
              style: style.copyWith(
                color: wasted.isNotEmpty ? const Color(0xFFEF4444) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteAnalysis() {
    return _section(
      'Waste Analysis',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _miniKPI('TOTAL WASTE', '350', 'meals'),
              const SizedBox(width: 24),
              _miniKPI('MOST WASTED', 'Lunch', '(328)'),
            ],
          ),
          const SizedBox(height: 16),

        ],
      ),
    );
  }

  Widget _miniKPI(String label, String value, String suffix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                suffix,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExportButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _exportBtn(
              Icons.table_chart_outlined,
              'Export CSV',
              const Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _exportBtn(
              Icons.picture_as_pdf_outlined,
              'Export PDF',
              const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _exportBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
