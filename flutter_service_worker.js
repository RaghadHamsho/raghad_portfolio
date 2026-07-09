'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b2f938e6cd6490fcaa1e941129f9ca78",
"assets/AssetManifest.bin.json": "185de4e7d6de8eddc5d568d1c7bdfeb5",
"assets/AssetManifest.json": "930475b90a0e8444a53ecaba36472500",
"assets/assets/agile.png": "b2326cb4d8a232ae4f86478739aa38b8",
"assets/assets/al_meera/screen1.png": "0c6eec43e055edd96f90ccc1f7c61e3d",
"assets/assets/al_meera/screen10.png": "ba9a15c70c309554549622d2b7dd4873",
"assets/assets/al_meera/screen2.png": "dabd18e6a12ef74c088d9ce7f621c0d7",
"assets/assets/al_meera/screen3.png": "0f39a68da45c8a5b0f1efc97beddb150",
"assets/assets/al_meera/screen4.png": "48b870015b73f3fae54a334de3f3b17c",
"assets/assets/al_meera/screen5.png": "28ec88167d65105abe4c7063dcaa9ed9",
"assets/assets/al_meera/screen6.png": "a049253ab5ae09aad0367e54d57d82ce",
"assets/assets/al_meera/screen7.png": "818702c005782c50b438e57b305be808",
"assets/assets/al_meera/screen8.png": "bdcda655d2f3cc73ce48ea8111ee662d",
"assets/assets/al_meera/screen9.png": "8bd2f6177ad69aa34f5871d2d13d24f0",
"assets/assets/android.png": "992839166e7f78bfb678a8ee39a586fb",
"assets/assets/api.png": "7378618b1cee19cc9fc2be684f5cb44a",
"assets/assets/bloc.png": "51e91b917ce764c3a3a6cd12a3b2846b",
"assets/assets/clean_architecture.png": "1586b0fc333a4ec4d35f94508db53205",
"assets/assets/cms/screen1.png": "4c5201ae3011d8366438b58d635c293f",
"assets/assets/cms/screen10.png": "d47586b777087617a00843b23ae5054d",
"assets/assets/cms/screen11.png": "e697e6df2ce7cb4233d9bd02d8f738a0",
"assets/assets/cms/screen17.png": "3e57c1cd2305743d1c555b24fa4eb8c6",
"assets/assets/cms/screen2.png": "78c73fcbf607c8682ff6d953c3427443",
"assets/assets/cms/screen3.png": "b6985d23072aa13d4c36728b5ad7b6e6",
"assets/assets/cms/screen4.png": "c7d5ad94ea7fe2954bd438f94b71174a",
"assets/assets/cms/screen5.png": "a670de3a3c85e4cf4842c4f575b208bb",
"assets/assets/cms/screen6.png": "f72cecef5f7afd391ac8628a50c6e92b",
"assets/assets/cms/screen7.png": "a280494341da4623dcb3703d20bb79b6",
"assets/assets/cms/screen8.png": "17686eee8465438e4ab219e5662906ee",
"assets/assets/cms/screen9.png": "8d08b43b1e1646ce9e8c9685b1356f9d",
"assets/assets/code.png": "826f767324e81647c3bff2aa1d543f62",
"assets/assets/Dart.png": "97c2c326ac5312fce2a0b89126aafc6f",
"assets/assets/ehsan/screen1.jpg": "e3ab41a91d8711dae5725733d4fd64d8",
"assets/assets/ehsan/screen10.jpg": "f0de4b92cdc8ba628a7b7672fff3b1c0",
"assets/assets/ehsan/screen11.jpg": "22405f7198f08271ac44b843e999eafb",
"assets/assets/ehsan/screen2.jpg": "6cab7efd0b8930b90bb7cf29bef76401",
"assets/assets/ehsan/screen3.jpg": "4da6a2f3e444a7b4aa78892f0e6fd4f5",
"assets/assets/ehsan/screen4.jpg": "91db185aad6746cd74f0271df8c95a70",
"assets/assets/ehsan/screen5.jpg": "048cc3705b8f8eea89f9299eba20e95d",
"assets/assets/ehsan/screen6.jpg": "e341ce3bc122bbde9f857cf9cdf50073",
"assets/assets/ehsan/screen7.jpg": "5f9e273e496edd39af4722ff2d61bc0e",
"assets/assets/ehsan/screen8.jpg": "e0e899b73f540644619cea7cd3d712c3",
"assets/assets/ehsan/screen9.jpg": "06419fe7b6a1ef1671df1b1539feca1a",
"assets/assets/figma.png": "7df00a3c91dc53aadac0473e6b38d941",
"assets/assets/firebase.png": "14a44055eccc898b2acbac4d8a0bb670",
"assets/assets/flutter.png": "bf49d4957b31f5441bd35f389e36239e",
"assets/assets/git.png": "1522d46893725179120d9b8b9206a848",
"assets/assets/google.png": "bf66c3bf2ac521e858781d594c7f7f35",
"assets/assets/laravel.png": "bf9c5714091cab87024a3178e33e8144",
"assets/assets/lotus_buds/screen1.png": "0cdcaf41df1bd55a51c09c931f23b291",
"assets/assets/lotus_buds/screen2.png": "2ee5f6e3ebdf789c38253d2228c81ef5",
"assets/assets/lotus_buds/screen3.png": "c4c93af30f17220896f020509e433eb2",
"assets/assets/lotus_buds/screen4.png": "9957ccb6f299cc0039fc2e99b54f60a3",
"assets/assets/lotus_buds/screen5.png": "ce475fb003f25a3bf9fcf3e1e96fef45",
"assets/assets/lotus_buds/screen6.png": "b9b47cb4a2f5e9b8045f8dcdf1d43573",
"assets/assets/lotus_buds/screen7.png": "fac09d32068ad627f9c4425ba3452807",
"assets/assets/lotus_buds/screen8.png": "91cb9f7b78e356284899866748d70489",
"assets/assets/lotus_buds/screen9.png": "cd33aefa17909a264dc70ee8c167d198",
"assets/assets/loyalty/screen1.png": "4216fa906cf16af28efb97e4581aabe1",
"assets/assets/loyalty/screen10.png": "1871f8d646970e1b93f075d794d4d5fe",
"assets/assets/loyalty/screen2.png": "1a1b2b9cb159cb665fbcee5c52d3a9e4",
"assets/assets/loyalty/screen3.png": "e7495f88eba23ae06674b48522e32a01",
"assets/assets/loyalty/screen4.png": "471e6f47dcad8b2d3db839e4508e213a",
"assets/assets/loyalty/screen5.png": "411c258d5da9220e7b5ad1b67c6e5122",
"assets/assets/loyalty/screen6.png": "367d9fbd4211928224675699851fd9e3",
"assets/assets/loyalty/screen7.png": "1b00fe5c448844f8039b84d25016ae1e",
"assets/assets/loyalty/screen8.png": "3f5867ca4cfd6c310dfabe03714e5925",
"assets/assets/loyalty/screen9.png": "11bb6342874704b15dfe096a741eeb07",
"assets/assets/lusso/screen1.png": "b3bf6a0263cae4bb85a1c70df77d5048",
"assets/assets/lusso/screen2.png": "34e9733ab848e9b6c60c842e146f03c0",
"assets/assets/lusso/screen3.png": "0165f367bcb962ecc2384b85c02fc324",
"assets/assets/lusso/screen4.png": "fb5d130390320508a99949ae0de035c1",
"assets/assets/lusso/screen5.png": "90698770d2a5906b39c39f0cd619471c",
"assets/assets/lusso/screen6.png": "c4d5b829bcd07ac74948db3c2eccc682",
"assets/assets/lusso/screen7.png": "a280494341da4623dcb3703d20bb79b6",
"assets/assets/lusso/screen8.png": "b05b49dd630ed92ff1f32236bc647749",
"assets/assets/lusso/screen9.png": "8d08b43b1e1646ce9e8c9685b1356f9d",
"assets/assets/meeting/screen1.png": "3104da3fb36f4973476c7600818cd8db",
"assets/assets/meeting/screen12.png": "6695045024e24c3fc90545f25e57038d",
"assets/assets/meeting/screen13.png": "e79003aef0a44eeeba2acd54fe114a17",
"assets/assets/meeting/screen2.png": "d66044be1f3642b86f5f10f5d5509468",
"assets/assets/meeting/screen3.png": "e4002be6c727715830855461938cfbfa",
"assets/assets/meeting/screen4.png": "5f787037f23ddcde02e44798a66640e1",
"assets/assets/meeting/screen5.png": "40315e5f7b528bced169862222396800",
"assets/assets/meeting/screen6.png": "79d065df39957fda3fc6ae86a86cd879",
"assets/assets/meeting/screen7.png": "500d5fc3fc0584a91f677d0ab6df6ed7",
"assets/assets/meeting/screen8.png": "572b25cdd1620e940b290ea9938e1473",
"assets/assets/meeting/screen9.png": "10127f1c8b3a0a9a882a5a55453c2957",
"assets/assets/mvc.png": "fc1cfe32c49cb63a8cd47cfbf8074654",
"assets/assets/placeholder.png": "7b486e258eb36e316f65c1eaca652a3c",
"assets/assets/responsive.png": "dfb3f047fb7487ab5fd6ed628648bba5",
"assets/assets/socket.png": "b8de372c00aeeec56f5da4b0e7899ae2",
"assets/assets/sql.png": "9ecb219269beca84ca8e7f5b6ee9be1b",
"assets/assets/ux-ui.png": "5efc96992b821963b15a6927c37dfd94",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "e97112b1d4127eabd5be19753afb6dbf",
"assets/NOTICES": "6703f2c83b39617699f967b779fa330a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "dafb4de91af14a2e7b4431a60c4f7045",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "5b8d20acec3e57711717f61417c1be44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "bd7bacf36d966a072b6b8acdcef5161a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "015f544ab4230b13cb796ea8b36e66dc",
"/": "015f544ab4230b13cb796ea8b36e66dc",
"main.dart.js": "aab329e8664c77a311ce8aa472fa616d",
"manifest.json": "2c108c1494bdf71f3ef915fe6600a0d8",
"version.json": "4bb01fd9ff40d12d525ddfc545a36188"};
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
