#默认
```
server {
	listen 80;
	listen [::]:80;

	server_name xx.com;

	root /data/www/example.com;
	index index.html;

	location / {
		try_files $uri $uri/ =404;
	}
}
```
