// flutter_service_worker.js

// Cache name
var cacheName = "flutter-app-cache";

// Files to cache
var filesToCache = [
  "/",
  "/index.html",
  // Add other assets (CSS, JavaScript, images) here
];

// Install event
self.addEventListener("install", function (event) {
  event.waitUntil(
    caches.open(cacheName).then(function (cache) {
      return cache.addAll(filesToCache);
    })
  );
});

// Fetch event
self.addEventListener("fetch", function (event) {
  event.respondWith(
    caches.match(event.request).then(function (response) {
      return response || fetch(event.request);
    })
  );
});
