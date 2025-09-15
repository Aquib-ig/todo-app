import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/themes/app_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/screens/auth/auth_wrapper.dart';
import 'package:todo_app/services/todo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Theme Provider
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        
        // Auth Provider
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        
        // Todo Provider
        ChangeNotifierProvider(
          create: (_) => TodoProvider(
            TodoRepository(TodoService()),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            
            // Themes
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.isDarkMode 
                ? ThemeMode.dark 
                : ThemeMode.light,
            
            // Text scaling
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: themeProvider.textSize,
                ),
                child: child!,
              );
            },
            
            // Home
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}
