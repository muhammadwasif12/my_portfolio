'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "07d12327f214fd9af4cc1e802b7461f2",
"assets/AssetManifest.bin.json": "c78a40455e44d89ed852217d53ff599e",
"assets/AssetManifest.json": "507724073616bdafe1253e56d9d5fd1e",
"assets/assets/icons/android_studio.png": "60a6bef052032b1851455d4e0d737fa4",
"assets/assets/icons/cli.png": "511875288358254a1a0e4651ad009224",
"assets/assets/icons/dart.png": "827ad8382451bed999b2c2967740296f",
"assets/assets/icons/database.png": "1040b6147765bd75c47150b18366cb0f",
"assets/assets/icons/figma.png": "a833064cc1ea341c925488c169df16c8",
"assets/assets/icons/firebase.png": "15bef1078f0dcfd05d4dc5eb256bf169",
"assets/assets/icons/flutter.png": "2fa58e1115cbd404709e8e74fd8ae11d",
"assets/assets/icons/git.png": "847745b86d99b96be50452cd4dbd2ff3",
"assets/assets/icons/github.png": "559d3501991f9fee9140c695751b8efd",
"assets/assets/icons/java.png": "2a4f237d39d2b462e544e09ba8d757d7",
"assets/assets/icons/linkedin.png": "f0d82f9c7f1cae38da5bd69fdc3d59cc",
"assets/assets/icons/mongodb.png": "9c8e9c48fe9813c2c42ae9061de50558",
"assets/assets/icons/restapi.png": "82e369b9e9d6aed6f38110ece56b34d3",
"assets/assets/icons/supabase.png": "fa6577a01e7c77a4d84a30b64978dec5",
"assets/assets/icons/vscode.png": "89711749bdbb1f1f466a8f720a79387f",
"assets/assets/images/profile.jpg": "90e519e73e16dbc073bbe16706f5444c",
"assets/assets/projects/chat.jpg": "5367a01e835af3b47e0002bf77815edc",
"assets/assets/projects/deenkit.jpg": "9505349012d0d3567463bb942f6d4ea8",
"assets/assets/projects/favplaces.jpg": "7dbd6136e964c2ac0977bb5c393bd0df",
"assets/assets/projects/islamic.jpg": "4ebaad0f7c1314583876f1b8dcd201b3",
"assets/assets/projects/meals.jpg": "c45325e66f95c2059b7c85873ab9c953",
"assets/assets/projects/movievault.jpg": "d957f10fb71d3f2d1f255882c2546029",
"assets/assets/projects/taskmanager.jpg": "d643e8357a8dec4c2d364e48b64d9e17",
"assets/FontManifest.json": "36a45e976f10a430e9d4143c423c4e43",
"assets/fonts/MaterialIcons-Regular.otf": "2d19b1d2068fa53651ed74960a957261",
"assets/NOTICES": "745a6b8d03085bbf0cd29858b384f43f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "15d54d142da2f2d6f2e90ed1d55121af",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "fb907701b1fe0fb3c96805068972096a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "74d94b17fb880f040607d5079cc00140",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w100.ttf": "13fd755e07c8d70cd49387ad9a2cb853",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w200.ttf": "53e58f44522cbeb659ddaa1d5b63bc8f",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w300.ttf": "8ca937f07423865d6d8c0215f9dcfeeb",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w400.ttf": "3115098703d046eea3472b37da643037",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w500.ttf": "92f641c287e193b6799fbd5ff6176290",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w600.ttf": "7de32348d080f0732d29674fb7d364b1",
"assets/packages/lucide_icons_flutter/assets/lucide.ttf": "af594b723d134d2d1199ea7497b0625a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "cdd8a65af4bd086efbad1ecd9306a64e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ef520fe0da1d65f2d13c54357266e8c1",
"/": "ef520fe0da1d65f2d13c54357266e8c1",
"main.dart.js": "9d9700ee48d9ddd09a8a75c9d1f4a71f",
"manifest.json": "d8fe34f7ae4c072a77b924e01dac8a50",
"version.json": "9b818ca9511483c901bed1545384376c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
