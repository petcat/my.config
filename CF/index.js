const shortLinks = [
  { key: 'b', value: 'https://www.bityun.co/#/register?code=HBBW8RJB' },
  { key: '1', value: 'https://justmysocks2.net/members/aff.php?aff=247&gid=1' },
  { key: 's', value: 'https://suying66.com/auth/register?code=59Ku' },
  { key: '9', value: 'https://cutecloud.space/aff.php?aff=1943&gid=1' },
]

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})
/**
 * Respond with hello worker text
 * @param {Request} request
 */
async function handleRequest(request) {
  r = request.url.split('/')

  res = matchReq(r[r.length - 1])

  if (res === null) {
    return new Response('404 :(', {
      headers: { 'content-type': 'text/plain' },
    })
  }

  return Response.redirect(res, 301)
}

function matchReq(part) {
  for (i = 0; i < shortLinks.length; i++) {
    j = shortLinks[i]
    if (part === j.key) {
      return j.value
    }
  }
  return null
}
