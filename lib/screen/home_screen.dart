import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


//Clase principal
class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({super.key, required this.toggleTheme, required this.isDarkMode});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('Moodia Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: widget.toggleTheme,
          ), //IconButton para cambiar el tema
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget> [
            // Calendario semanal
            TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2050, 1, 1),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const { 
              CalendarFormat.week: 'Semana'  //Solo permite el formato de una semana
            },
            daysOfWeekHeight: 40,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold),
              weekendStyle: const TextStyle(
                fontSize: 12,
                color: Colors.red),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 40,),
          Text("Comienza tu camino añadiendo tus emociones del día de hoy.", textAlign: TextAlign.center,),
          //Imagen dinamica segun el tema
          Image.asset(
            Theme.of(context).brightness == Brightness.light
              ? "assets/moodiaLight.png" // Imagen para tema claro
              : "assets/moodiaBlack.png",  // Imagen para tema oscuro
            width: 250,
            height: 250,
          ),
          ],
        ),
      ),
      //Barra de navegación inferior
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarTheme.color, 
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.edit_note_rounded),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            
          ],
        ),
      ),
      //Botton para agregar una nueva entrada
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
