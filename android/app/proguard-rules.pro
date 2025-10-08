# Keep OkHttp and Dio network classes
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
#
## Keep Flutter plugin classes
#-keep class io.flutter.embedding.** { *; }
#-keep class io.flutter.plugin.** { *; }
#
## Keep Gson/JSON classes if used
#-keep class com.google.gson.** { *; }
#
## Keep model classes you serialize (adjust package name)
#-keep class com.suganta.education.models.** { *; }
#
## Keep annotations
#-keepattributes *Annotation*
#
## Keep Play Core classes (for deferred components)
#-keep class com.google.android.play.core.** { *; }
#-keep interface com.google.android.play.core.** { *; }
#
## Keep Flutter deferred component classes
#-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
#
## Keep Play Core tasks
#-keep class com.google.android.play.core.tasks.** { *; }
