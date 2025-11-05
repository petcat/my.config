const urlMap = {
  "a": "https://www.apple.com",
  "b": "https://www.bing.com",
  "c": "https://www.cloudflare.com",
};

export default {
  async fetch(request) {
    const url = new URL(request.url);
    const path = url.pathname.slice(1); // 去掉前导斜杠

    // 如果路径存在于映射表中，执行 301 跳转
    if (urlMap[path]) {
      return Response.redirect(urlMap[path], 301);
    }

    // 否则返回 404 页面
    return new Response(`
      <html>
        <head><title>404 Not Found</title></head>
        <body>
          <h1>404 - 短链接不存在</h1>
          <p>路径 <code>/${path}</code> 没有对应的跳转地址。</p>
        </body>
      </html>
    `, {
      status: 404,
      headers: { "Content-Type": "text/html; charset=utf-8" },
    });
  }
};
