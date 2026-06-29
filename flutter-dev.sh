#!/usr/bin/env bash

# 1. Clean old process states
rm -f /tmp/flutter.pid

# 2. Spin up the Flutter app with tracking enabled
flutter run --pid-file=/tmp/flutter.pid "$@" &
FLUTTER_JOB_PID=$!

# 3. Give Flutter a moment to populate the target PID file
echo "Waiting for Flutter engine to initialize..."
while [ ! -f /tmp/flutter.pid ]; do
  # Exit early if the main flutter app crashes on boot
  if ! kill -0 $FLUTTER_JOB_PID 2>/dev/null; then
    echo "Flutter failed to launch."
    exit 1
  fi
  sleep 0.5
done # <-- Fixed this line (changed from ')' to 'done')

# 4. Spin up the entr hot-reload loop silently in the background
echo "File watcher attached. Saving *.dart files will hot reload instantly."
find lib/ -name "*.dart" | entr -r kill -USR1 $(cat /tmp/flutter.pid) 2>/dev/null &
WATCHER_PID=$!

# 5. Keep the foreground alive. If you exit the app (q), kill the background watcher.
wait $FLUTTER_JOB_PID
kill $WATCHER_PID 2>/dev/null
rm -f /tmp/flutter.pid
