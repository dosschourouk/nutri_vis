plugins {
    id("com.android.application")
    id("kotlin-android")
    // Le plugin Flutter doit rester ici
    id("dev.flutter.flutter-gradle-plugin")
    // AJOUT INDISPENSABLE : Plugin Google Services pour Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.nutri_vis"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.nutri_vis"
        
        // MODIFICATION : Forcer le minSdk à 21 (requis par Firebase pour éviter l'écran blanc)
        minSdk = 21 
        
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // AJOUT : Activation du MultiDex pour supporter toutes les librairies Firebase
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // AJOUT : Dépendance pour le MultiDex
    implementation("com.android.support:multidex:1.0.3")
}