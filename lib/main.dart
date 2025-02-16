import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

//Clase principal
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; //Esatado inicial con tema claro

  //Método que alterna entre modo claro y oscuro
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodia Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.green.shade200,
          onPrimary: Colors.black, 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade200,
          foregroundColor: Colors.black,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.green.shade200,
        ),
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 20, 119, 144),
          onPrimary: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 20, 119, 144),
          foregroundColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: const Color.fromARGB(255, 20, 119, 144),
        ),
      ),
      themeMode: _themeMode, //tema dinamico
      home: HomePage(title: 'Moodia Home Page', toggleTheme: _toggleTheme),
    );
  }
}

//Pagina principal de la aplicación 
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.toggleTheme});

  final String title;
  final VoidCallback toggleTheme; //Funcion para cambiar el tema 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
        actions: [
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
