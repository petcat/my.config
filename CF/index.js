const shortLinks = [
  //  服务器 { key: '', value: '' },
  { key: 'do', value: 'https://m.do.co/c/a029e98719e8' },
  { key: 'vu', value: 'https://www.vultr.com/?ref=8406801-6G' },
  { key: 'cc', value: 'https://app.cloudcone.com/?ref=2624' },
  { key: 'on', value: 'https://www.onlinenic.com/en/Home/cloudReferral.html?usercode=0da7c2934ffb9a53405677661dac0085' },
  { key: 'pr', value: 'https://pacificrack.com/portal/aff.php?aff=39' },
  //  机场
  { key: 'b', value: 'https://www.bityun.co/#/register?code=HBBW8RJB' },
  { key: '1', value: 'https://justmysocks2.net/members/aff.php?aff=247&gid=1' },
  { key: 's', value: 'https://suying66.com/auth/register?code=59Ku' },
  { key: '9', value: 'https://cutecloud.space/aff.php?aff=1943&gid=1' },
  { key: 'r', value: 'https://ssrssr.xyz/aff/hsXx' },
  { key: 'd', value: 'https://pud.life/aff/VpNb' },
  { key: 'g', value: 'https://www.gbssr.com/auth/register?code=MZmS' },
  { key: 'o', value: 'https://5socloud.gq/auth/register?code=U1il' },
  { key: 'q', value: 'http://t.smxhx.com/aff.php?aff=479&gid=1' },
  { key: 'i', value: 'https://www.v2dy.co/#/register?code=PDEk7B5C' },
  { key: '0', value: 'https://xbnet.site/i/iv200628/NNmbmfw' },
  { key: 'y', value: 'https://youyun999.net/auth/register?code=6JW9' },
  { key: 'w', value: 'https://faster.bleakone.xyz/?code=mKIB' },
  { key: 'a', value: 'https://aaex.uk/aff.php?aff=1962&gid=1&language=chinese' },
  { key: '4', value: 'https://v2board.v2ray.life/#/register?code=hyhJ63CX' },
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
