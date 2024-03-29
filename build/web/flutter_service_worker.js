'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "34caa20b38b1ab476cbae902a129c2c6",
"version.json": "3d4f8fdc6074510f777825857d04b56d",
"assets/assets/images/notfound.png": "103205647c1743a3ed5786f255587616",
"assets/assets/images/loading.svg": "5f0814b624e361da1c6a418643e5a009",
"assets/assets/demo/data/locknloadairsoft_products.json": "d615089e7d32dac28454e4b6894aecd6",
"assets/assets/demo/data/halloweenmakeup_store.json": "f6eb3ea874d4e488e61ba55bf9ca440f",
"assets/assets/demo/data/woodstockchimes_products.json": "0e38df7bd86d14bc13f5eb07bd11d932",
"assets/assets/demo/data/commonfarmflowers_products.json": "ee9d0ee724be89278b433011e8af070c",
"assets/assets/demo/data/nixon_store.json": "e9ef6624d1b87ee59f3257610adf5777",
"assets/assets/demo/data/ruesco_products.json": "e8fb0e3ae6fc2ab55af52d351c80082b",
"assets/assets/demo/data/thebookbundler_products.json": "830ad9b8f31b9d9226a6fcff7225afa2",
"assets/assets/demo/data/seriouswatches_store.json": "12c06495cb431221d91f4f0608733472",
"assets/assets/demo/data/stores.sh": "581ad0ebbc244bf0c428680b68c33d6b",
"assets/assets/demo/data/woodstockchimes_store.json": "a8a91532b0e93c1153847626631cc0d5",
"assets/assets/demo/data/simplybagz_store.json": "d5e2da43eef96ee30b9f4d2e13bc71f7",
"assets/assets/demo/data/commonfarmflowers_store.json": "6a46431db04c2fb1452807bfe4653ff8",
"assets/assets/demo/data/halloweenmakeup_products.json": "1a86bae617f0e7fcdc9316df65a35e61",
"assets/assets/demo/data/simplybagz_products.json": "8d13ed030a4e96265740a07f7eb6b5b0",
"assets/assets/demo/data/atelierdubraceletparisien_products.json": "1bad9a09d5a2c7fad7b8b88344482611",
"assets/assets/demo/data/huel_store.json": "058dcf76ec507d9415125c9884fb15cd",
"assets/assets/demo/data/locknloadairsoft_store.json": "9c5f5bfbd58bdcd86882321193d1dd9c",
"assets/assets/demo/data/thebookbundler_store.json": "822248b434b6477e61d262f152f63c31",
"assets/assets/demo/data/seriouswatches_products.json": "3337015237b5dd40b89a3e49c7ebd7b8",
"assets/assets/demo/data/nixon_products.json": "4fa0b736c764784e55778055e48b6254",
"assets/assets/demo/data/huel_products.json": "3adf338ef8e67c7f74bb081d1a56e0a1",
"assets/assets/demo/data/atelierdubraceletparisien_store.json": "71b508f62182d4645a78ac0e352413ad",
"assets/assets/demo/data/ruesco_store.json": "25ba9c1710cee87fc1ddc1c8e01ec3a3",
"assets/assets/demo/images/qrcode6.png": "eca7c5674f987e20250a8b578f6db914",
"assets/assets/demo/images/qrcode1.png": "82fe28a782a089694262984ba856d59c",
"assets/assets/demo/images/qrcode5.png": "33c91139357d73050fd2fa6dc6f7a626",
"assets/assets/demo/images/bulk_codes.png": "5705ff75a58b1da0b051803eabb52625",
"assets/assets/demo/images/qrcode2.png": "eaa53577798d7cd31bf5103171c5ea18",
"assets/assets/demo/images/qrcode4.png": "585f326352c8646d9b0570cf9395397b",
"assets/assets/demo/images/qrcode7.png": "15b307f692fa77df8a09130972df31a8",
"assets/assets/demo/images/qrcode3.png": "0215753f14863ab400763b463ac2640f",
"assets/assets/print.html": "bb7c2ccb721cecaf15508d49e058adce",
"assets/assets/icons/logo.png": "aef5c5138f33995ed180b509c322247b",
"assets/assets/icons/logo.svg": "95426e12458ce0fc20edf782480206ce",
"assets/assets/icons/logo-small.png": "3ca866f68261071f2f71bdb55bc9e27a",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/NOTICES": "3f356622bd7b76344c301033d73fc102",
"assets/AssetManifest.json": "dfec77beb7a1a239b10b4fef70bc79fc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"manifest.json": "12fa2854a79c7b25ba9a5c23e7322429",
"main.dart.js": "b7528a9c421461ff1f50d0632b716791",
"index.html": "816bea7566963d38466f867358aa5fb5",
"/": "816bea7566963d38466f867358aa5fb5",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"icons/logo-192.png": "1a29ef466ee6bb1d1fd4973cfaee7483",
"icons/logo-512.png": "a452076a2ed8e1eccb6de66b7bae9a3f"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
