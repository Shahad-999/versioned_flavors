1. create a new project
2. run flutter pub add package_info_plus
3. add flavors to the project

   ```
   flavors:
   development:
   app:
     name: development

   android:
     applicationId: "com.example.versioned_flavors.development"
   ios:
     bundleId: "com.example.versioned_flavors.development"
   production:
   app:
     name: production

   android:
     applicationId: "com.example.versioned_flavors.production"
   ios:
     bundleId: "com.example.versioned_flavors.production"
   ```

staging:
app:
name: staging

    android:
      applicationId: "com.example.versioned_flavors.staging"
    ios:
      bundleId: "com.example.versioned_flavors.staging"

    ```

4. upadte the launch.json file to include the flavors

```
 {
            "name": "versioned_flavors debug production",
            "request": "launch",
            "type": "dart",
            "args": [
                "--flavor",
                "production",
            ]
        },
        {
            "name": "versioned_flavors profile production",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "args": [
                "--flavor",
                "production",
            ]
        },
        {
            "name": "versioned_flavors release production",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args": [
                "--flavor",
                "production",
            ]
        },
```
