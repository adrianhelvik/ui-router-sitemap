// Generated by CoffeeScript 1.10.0
(function() {
  var createSiteMap;

  createSiteMap = function(domain, noParams, complete) {
    var result, state, url;
    domain = domain.replace(/[\/]+$/, '');
    console.log(domain);
    result = '<?xml version="1.0" encoding="utf-8"?>\n' + '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" \n' + '  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \n' + '  xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">\n';
    for (state in noParams) {
      url = noParams[state];
      url = url.replace(/^[\/]+/, '');
      result += "  <url><loc>" + domain + "/" + url + "</loc></url>\n";
    }
    result += '</urlset>';
    return complete(null, result);
  };

  module.exports = createSiteMap;

}).call(this);
