# 📝 Todo App

A simple Todo application with a **Flutter frontend** and **Node.js + Express + MongoDB backend**.

## 📂 Project Structure

    todo-app/
      backend/   # Node.js + Express + MongoDB API
      frontend/  # Flutter mobile app

## 🚀 Getting Started

### 🔧 Backend

1. Go to the backend folder:

   cd backend

2. Install dependencies:

   npm install

3. Create a `.env` file in the `backend/` folder and add:

   PORT=3000
   MONGO_URI=mongodb://localhost:27017/todoapp
   JWT_SECRET=your_jwt_secret_here

4. Start the server:

   npm run dev

> API runs at: http://localhost:3000

### 📱 Frontend

1. Go to the frontend folder:

   cd frontend

2. Get Flutter dependencies:

   flutter pub get

3. Update the API base URL in your Flutter code (e.g., `lib/services/api.dart`) to match your backend:

   const String apiUrl = "http://10.0.2.2:3000"; // Android emulator
   // or "http://<YOUR_MACHINE_IP>:3000" if testing on a physical device
   // or "http://localhost:3000" if running Flutter web

4. Run the app on a connected device/emulator:

   flutter run

## 🔧 Notes / Tips

- If your app shows the folder name (e.g., `frontend`) as the app label:
  - Android: edit `android/app/src/main/AndroidManifest.xml` -> `android:label="Todo App"`
  - iOS: edit `ios/Runner/Info.plist` -> `CFBundleName = "Todo App"`
  - Or use `flutter_launcher_name` to automate renaming.
- To change the app icon quickly, use `flutter_launcher_icons` and provide a 1024x1024 PNG.
- For Android emulator to reach backend on host machine use `10.0.2.2`. For Genymotion use `10.0.3.2`.
- If testing on a physical device, use your machine's LAN IP (e.g., `http://192.168.x.x:3000`) and ensure firewall allows connections.

## ✨ Features

- Add, update, delete todos
- Data stored in MongoDB (local or Atlas)
- Cross-platform mobile app (iOS & Android)
- Simple, clean architecture

## 🛠️ Tech Stack

- **Frontend:** Flutter
- **Backend:** Node.js, Express.js
- **Database:** MongoDB

## 🧭 API (example endpoints)

- `GET /todos` -> list todos
- `POST /todos` -> create todo
- `PUT /todos/:id` -> update todo
- `DELETE /todos/:id` -> delete todo

## 📸 Screenshots

_Add screenshots of your app into `/docs/screenshots` and reference them here (optional)._

## 🤝 Contributing

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit: `git commit -m "feat: description"`
4. Push & open a PR

## 📄 License

MIT License — see LICENSE file.

## Contact

Have questions or need help? Open an issue or contact the maintainer.
