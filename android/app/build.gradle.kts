import java.util.Properties
import java.io.File
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter Plugin MUST remain here
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropsFile = rootProject.file("key.properties")
val keystoreProps = Properties()
val hasReleaseKeystore = keystorePropsFile.exists().also { exists ->
    if (exists) {
        keystoreProps.load(FileInputStream(keystorePropsFile))
    }
}

android {
    namespace = "com.beh.eyedoctor"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
    isCoreLibraryDesugaringEnabled = true   // ✅ ADD
}


    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.beh.eyedoctor"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

 signingConfigs {
    create("release") {
        if (hasReleaseKeystore) {
            val storeFilePath = keystoreProps.getProperty("storeFile")
                ?: throw GradleException("key.properties is missing 'storeFile'")
            storeFile = rootProject.file(storeFilePath)
            storePassword = keystoreProps.getProperty("storePassword")
                ?: throw GradleException("key.properties is missing 'storePassword'")
            keyAlias = keystoreProps.getProperty("keyAlias")
                ?: throw GradleException("key.properties is missing 'keyAlias'")
            keyPassword = keystoreProps.getProperty("keyPassword")
                ?: throw GradleException("key.properties is missing 'keyPassword'")
        }
    }
}


    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = if (hasReleaseKeystore) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }

        getByName("debug") {
            // Use default Flutter debug keystore
            // No need to assign signingConfig explicitly
        }
    }
}
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}


flutter {
    source = "../.."
}
