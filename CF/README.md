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
