# مطالعه امتحان جامع - موتورهای جستجو و بازاریابی الکترونیک

A comprehensive Flutter web application for studying and taking quizzes on search engines and digital marketing topics, designed with Persian RTL support and responsive design.

## 🌟 Features

- **📚 Study Topics**: Interactive study materials organized by categories
- **🧪 Comprehensive Quiz**: Test your knowledge with randomized questions
- **📱 Responsive Design**: Works perfectly on mobile, tablet, and desktop
- **🌐 RTL Support**: Fully supports Persian right-to-left text direction
- **🎨 Modern UI**: Beautiful and intuitive user interface
- **⚡ Progressive Web App**: Can be installed on devices like a native app

## 🚀 Live Demo

The app is automatically deployed to GitHub Pages via CI/CD: 
**[https://yourusername.github.io/exammarketing/](https://yourusername.github.io/exammarketing/)**

*(Replace `yourusername` with your actual GitHub username)*

## 🛠️ Technologies Used

- **Flutter Web** - Cross-platform UI framework
- **Dart** - Programming language
- **GitHub Actions** - CI/CD pipeline
- **GitHub Pages** - Web hosting

## 📋 Prerequisites

- Flutter SDK (3.16.x or higher)
- Dart SDK
- Web browser for testing

## 🔧 Local Development

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/exammarketing.git
   cd exammarketing
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run -d chrome
   ```

4. **Run tests:**
   ```bash
   flutter test
   ```

5. **Build for web:**
   ```bash
   flutter build web
   ```

## 🚀 Deployment

### Automatic Deployment (CI/CD)

This project uses GitHub Actions for automatic deployment to GitHub Pages:

1. **Push to main/master branch** - Triggers the deployment pipeline
2. **Tests run automatically** - Ensures code quality
3. **Build process** - Creates optimized web build
4. **Deploy to GitHub Pages** - Makes the app live

### Manual Deployment

If you prefer manual deployment:

1. Build the web app:
   ```bash
   flutter build web --release --base-href "/exammarketing/"
   ```

2. The built files will be in `build/web/` directory

3. Deploy these files to your preferred hosting service

## ⚙️ GitHub Pages Setup

To enable GitHub Pages for your repository:

1. Go to your repository settings
2. Navigate to "Pages" section
3. Select "Deploy from a branch"
4. Choose "gh-pages" branch
5. Click "Save"

The GitHub Actions workflow will automatically create and manage the `gh-pages` branch.

## 🧪 Testing

The project includes automated tests that run in the CI/CD pipeline:

- **Widget Tests**: Verify UI components work correctly
- **Unit Tests**: Test business logic and utilities
- **Integration Tests**: Ensure proper app flow

Run tests locally:
```bash
flutter test
flutter analyze
```

## 📱 PWA Features

The app is configured as a Progressive Web App (PWA):

- **Installable**: Can be installed on devices
- **Offline Ready**: Basic offline functionality
- **Responsive**: Works on all screen sizes
- **Fast Loading**: Optimized for performance

## 🌍 Internationalization

- **Primary Language**: Persian (Farsi)
- **Text Direction**: Right-to-Left (RTL)
- **Fallback**: English support included

## 🔄 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/deploy.yml`) automatically:

1. ✅ Checks out the code
2. ⚙️ Sets up Flutter environment
3. 📦 Installs dependencies
4. 🔍 Runs code analysis
5. 🧪 Executes tests
6. 🏗️ Builds web application
7. 🚀 Deploys to GitHub Pages

## 📂 Project Structure

```
exammarketing/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   ├── utils/
│   └── widgets/
├── web/
│   ├── index.html
│   └── manifest.json
├── test/
├── .github/workflows/
│   └── deploy.yml
└── README.md
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Support

If you have any questions or issues, please open an issue on GitHub.

---

**Made with ❤️ using Flutter** | **Deployed with �� GitHub Actions**
