'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "34caa20b38b1ab476cbae902a129c2c6",
"version.json": "3d4f8fdc6074510f777825857d04b56d",
"assets/assets/images/notfound.png": "103205647c1743a3ed5786f255587616",
"assets/assets/images/loading.svg": "5f0814b624e361da1c6a418643e5a009",
"assets/assets/demo/data/locknloadairsoft_products.json": "424b7b18b4dc4411decf87d8c4c44315",
"assets/assets/demo/data/halloweenmakeup_store.json": "f6eb3ea874d4e488e61ba55bf9ca440f",
"assets/assets/demo/data/commonfarmflowers_products.json": "152f7bc5e9fbfa33db8f8afb480edc88",
"assets/assets/demo/data/nixon_store.json": "e9ef6624d1b87ee59f3257610adf5777",
"assets/assets/demo/data/ruesco_products.json": "a99302fc211784d08b249eb75f700fc0",
"assets/assets/demo/data/signatureveda_products.json": "7a6f68fc71f6ee17730e41d69982504e",
"assets/assets/demo/data/list.txt": "7cb7939f800af1650d687646a2612be7",
"assets/assets/demo/data/thebookbundler_products.json": "5985005a2c93ce6cb596ea8240ca8626",
"assets/assets/demo/data/seriouswatches_store.json": "12c06495cb431221d91f4f0608733472",
"assets/assets/demo/data/decathlon_store.json": "0e9b8f6fcd931e405664620af6bbb9c0",
"assets/assets/demo/data/commonfarmflowers_store.json": "6a46431db04c2fb1452807bfe4653ff8",
"assets/assets/demo/data/halloweenmakeup_products.json": "8ce332ca5902d7ff789b2e09742ace17",
"assets/assets/demo/data/atelierdubraceletparisien_products.json": "d894643069e63e3807885b5031a1f231",
"assets/assets/demo/data/huel_store.json": "058dcf76ec507d9415125c9884fb15cd",
"assets/assets/demo/data/locknloadairsoft_store.json": "9c5f5bfbd58bdcd86882321193d1dd9c",
"assets/assets/demo/data/decathlon_products.json": "cbe2044df1f35e63feecff113e19705a",
"assets/assets/demo/data/thebookbundler_store.json": "822248b434b6477e61d262f152f63c31",
"assets/assets/demo/data/seriouswatches_products.json": "b9066886c694b2eed9dad23b764208cf",
"assets/assets/demo/data/signatureveda_store.json": "6ee37d766cb4ae251ae2190ecbcb256f",
"assets/assets/demo/data/nixon_products.json": "852e769479b34dcdebf72f2e5dd85885",
"assets/assets/demo/data/huel_products.json": "a670df7093b3799aa1d88bb8db83c580",
"assets/assets/demo/data/atelierdubraceletparisien_store.json": "71b508f62182d4645a78ac0e352413ad",
"assets/assets/demo/data/ruesco_store.json": "25ba9c1710cee87fc1ddc1c8e01ec3a3",
"assets/assets/demo/images/qrcode6.png": "eca7c5674f987e20250a8b578f6db914",
"assets/assets/demo/images/qrcode1.png": "82fe28a782a089694262984ba856d59c",
"assets/assets/demo/images/qrcode5.png": "33c91139357d73050fd2fa6dc6f7a626",
"assets/assets/demo/images/qrcode2.png": "eaa53577798d7cd31bf5103171c5ea18",
"assets/assets/demo/images/qrcode4.png": "585f326352c8646d9b0570cf9395397b",
"assets/assets/demo/images/qrcode7.png": "15b307f692fa77df8a09130972df31a8",
"assets/assets/demo/images/qrcode3.png": "0215753f14863ab400763b463ac2640f",
"assets/assets/icons/logo.png": "aef5c5138f33995ed180b509c322247b",
"assets/assets/icons/logo.svg": "95426e12458ce0fc20edf782480206ce",
"assets/assets/icons/logo-small.png": "3ca866f68261071f2f71bdb55bc9e27a",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/NOTICES": "4a943c421576b6b6976e824f6e365ccd",
"assets/AssetManifest.json": "543c36f340fa68aea1bbcd022c5a63d9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"manifest.json": "12fa2854a79c7b25ba9a5c23e7322429",
"main.dart.js": "47bcde1cbbcfebb98561a2f23358aa30",
"index.html": "707396aacc1012820cacbc755762ccd1",
"/": "707396aacc1012820cacbc755762ccd1",
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
