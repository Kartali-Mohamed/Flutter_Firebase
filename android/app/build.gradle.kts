plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}


android {
    namespace = "com.example.firebase_app"
    compileSdk = 36
    ndkVersion = "27.0.12077973"
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.firebase_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Provides core functions for Kotlin, used by the Android host and many Flutter plugins.
    implementation("org.jetbrains.kotlin:kotlin-stdlib")

    // Allows the use of modern Java 8+ features (like streams and lambdas) on older Android versions (pre-API 26).
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Necessary to prevent the 64K method limit error when using many large libraries (like Firebase) on older Android devices (pre-API 21).
    implementation("androidx.multidex:multidex:2.0.1")

    // Defines compatible versions for ALL Firebase libraries used in this block (34.0.0).
    // This ensures they all work together without version conflicts.
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))

    // Adds the Firebase Analytics SDK to track user behavior and app events.
    implementation("com.google.firebase:firebase-analytics")

    // Adds the Firebase Cloud Messaging (FCM) SDK for sending and receiving push notifications.
    implementation("com.google.firebase:firebase-messaging")
}
