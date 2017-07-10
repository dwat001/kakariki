using System;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.IO;

namespace Kakariki.Blogs.LocalStorage
{
    /// <summary>
    /// Summary description for ManifestHandler
    /// </summary>
    public class ManifestHandler : IHttpHandler
    {
        private const string TextCacheManifest = "text/cache-manifest";
        public ManifestHandler()
        {

        }

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentEncoding = UTF8Encoding.UTF8;
            context.Response.ContentType = TextCacheManifest;
            using (TextWriter output = context.Response.Output)
            {
                output.WriteLine(
@"CACHE MANIFEST
# 12
LocalStorage.js
Modernizer.js
LocalStorageGoesOffline.aspx
/css/screen.css
/script/jquery-1.4.2.min.js
/script/jquery.tmpl.js
/script/knockout-1.2.1.js
NETWORK:
*");
                output.Flush();
            }
        }
    }
}
