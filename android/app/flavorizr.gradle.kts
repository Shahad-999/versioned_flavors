import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("development") {
            dimension = "flavor-type"
            applicationId = "com.example.versioned_flavors.development"
            resValue(type = "string", name = "app_name", value = "versioned_flavors development")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.example.versioned_flavors.production"
            resValue(type = "string", name = "app_name", value = "versioned_flavors production")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.example.versioned_flavors.staging"
            resValue(type = "string", name = "app_name", value = "versioned_flavors staging")
        }
    }
}