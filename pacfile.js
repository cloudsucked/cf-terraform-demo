addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request))

})

const createPacFile = (proxy_subdomain) => `
function FindProxyForURL(url,host)
{
    // No proxy for private (RFC 1918) IP addresses (intranet sites)
    if (isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
        isInNet(dnsResolve(host), "172.16.0.0", "255.240.0.0") ||
        isInNet(dnsResolve(host), "192.168.0.0", "255.255.0.0")) {
         return "DIRECT";
    }
  
    // No proxy for localhost
    if (isInNet(dnsResolve(host), "127.0.0.0", "255.0.0.0")) {
        return "DIRECT";
    }
 
    // Proxy all
    return 'HTTPS ${proxy_subdomain}.proxy.cloudflare-gateway.com:443';
}`

async function handleRequest(request) {
    const url = new URL(request.url)
    const proxy_subdomain = url.pathname.slice(1).split('.')[0]

    return new Response(createPacFile(proxy_subdomain))
}