## Aff转发

```
http://i.shadowsocksr.shop {
	redir /j https://jpeg.men
	redir /l https://hostloc.com
}
```



##### 白云, b,bi
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://www.bityun.co/#/register?code=HBBW8RJB' // 需要跳转到的地址
    return Response.redirect(url, 301)
}
```
##### 搬瓦工, 1
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://justmysocks2.net/members/aff.php?aff=247&gid=1' 
    return Response.redirect(url, 301)
}
```
##### 速鹰, su, s
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://suying66.com/auth/register?code=59Ku' 
    return Response.redirect(url, 301)
}
```
##### 9元, 9
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://cutecloud.space/aff.php?aff=1943&gid=1' 
    return Response.redirect(url, 301)
}
```
##### 安慕希, r,
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://ssrssr.xyz/aff/hsXx' 
    return Response.redirect(url, 301)
}
```
##### 小布丁, d
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://pud.life/aff/VpNb' 
    return Response.redirect(url, 301)
}
```
##### 全球通, g
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://www.gbssr.com/auth/register?code=MZmS' 
    return Response.redirect(url, 301)
}
```
##### socloud, o
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://5socloud.gq/auth/register?code=U1il' 
    return Response.redirect(url, 301)
}
```
##### 墙裂, q
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'http://t.smxhx.com/aff.php?aff=479&gid=1' 
    return Response.redirect(url, 301)
}
```
##### 艾可, i
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://www.v2dy.co/#/register?code=PDEk7B5C' 
    return Response.redirect(url, 301)
}
```
##### 西部, 0
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://xbnet.site/i/iv200628/NNmbmfw' 
    return Response.redirect(url, 301)
}
```
##### 优云, y
```
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
async function fetchAndApply(request) {
    url = 'https://youyun999.net/auth/register?code=6JW9' 
    return Response.redirect(url, 301)
}
```
---
### IBM Yes

```
addEventListener(
"fetch",event => {
let url=new URL(event.request.url);
url.hostname="ibmyes.us-south.cf.appdomain.cloud";
let request=new Request(url,event.request);
event. respondWith(
fetch(request)
)
}
)
```

---
### 反代TG频道
```
const upstream_me = 't.me';
const upstream_org = 'telegram.org';

// Custom pathname for the upstream website.
const upstream_path = '/s/bityun';

// Whether to use HTTPS protocol for upstream address.
const https = true;

// Replace texts.
const replace_dict = {
  $upstream: '$custom_domain'
};

addEventListener('fetch', event => {
  event.respondWith(fetchAndApply(event.request));
});

async function fetchAndApply(request) {
  let response = null;
  let url = new URL(request.url);
  let url_hostname = url.hostname;

  if (https == true) {
    url.protocol = 'https:';
  } else {
    url.protocol = 'http:';
  }

  var upstream_domain = upstream_me;

  // Check telegram.org
  let pathname = url.pathname;
  console.log(pathname);
  if (pathname.startsWith('/static')) {
    console.log('here');
    upstream_domain = upstream_org;
    url.pathname = pathname.replace('/static', '');
  } else {
    if (pathname == '/') {
      url.pathname = upstream_path;
    } else {
      url.pathname = upstream_path + url.pathname;
    }
  }

  url.host = upstream_domain;

  let method = request.method;
  let request_headers = request.headers;
  let new_request_headers = new Headers(request_headers);

  new_request_headers.set('Host', url.hostname);
  new_request_headers.set('Referer', url.hostname);

  let original_response = await fetch(url.href, {
    method: method,
    headers: new_request_headers
  });

  let original_response_clone = original_response.clone();
  let response_headers = original_response.headers;
  let new_response_headers = new Headers(response_headers);
  let status = original_response.status;

  response = new Response(original_response_clone.body, {
    status,
    headers: new_response_headers
  });
  let text = await response.text();

  // Modify it.
  let modified = text.replace(/telegram.org/g,'tg.k8s.li/static');

  // Return modified response.
  return new Response(modified, {
    status: response.status,
    statusText: response.statusText,
    headers: response.headers
  });
}
```
