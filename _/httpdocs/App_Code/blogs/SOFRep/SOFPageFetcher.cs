using System;
using System.Collections.Generic;
using System.Web;
using System.IO;

namespace Kakariki.Blog.SOFRep
{
    public class SOFPageFetcher
    {
        public void write(string format, int pageNumber, HttpContext context)
        {
            SOFCachePageFetcher cache = new SOFCachePageFetcher(context);
            if (cache.hasCachedPage(pageNumber, format))
            {
                cache.readFromCache(pageNumber, format, context.Response);
                return;
            }

            SOFNetPageFetcher net = new SOFNetPageFetcher();
            IList<UserSummary> summaries = net.getPage(pageNumber);
            using (MemoryStream ms = new MemoryStream(summaries.Count * 80))
            {
                writeToMemoryStream(format, summaries, ms);
                ms.Position = 0;
                cache.writeToCache(ms, pageNumber, format);
                ms.Position = 0;
                ms.WriteTo(context.Response.OutputStream);

            }

        }

        private void writeToMemoryStream(string format, IList<UserSummary> summaries, MemoryStream ms)
        {
            TextWriter memoryWriter = new StreamWriter(ms);

            switch (format)
            {
                case "HTML":
                    writeHtml(memoryWriter, summaries);
                    break;
                case "JSON":
                default:
                    writeJson(memoryWriter, summaries);
                    break;
            }

        }

        private void writeHtml(System.IO.TextWriter textWriter, IList<UserSummary> summaries)
        {
            textWriter.WriteLine("<table><tr><th>Rank</th><th>Reputation</th><th>Name</th></tr>");
            foreach (UserSummary user in summaries)
            {
                textWriter.WriteLine("<tr><td>{0}</td><td>{1}</td><td>{2}</td></tr>", user.Rank, user.Reputation, user.Name);
            }
            textWriter.Write("</table>");
            textWriter.Flush();
        }

        private void writeJson(System.IO.TextWriter textWriter, IList<UserSummary> summaries)
        {
            textWriter.Write("[");
            foreach (UserSummary user in summaries)
            {
                textWriter.Write("{3}Rank:{0}, Reputation:{1}, Name:'{2}'{4},", user.Rank, user.Reputation, user.Name.Replace("\\", "\\\\").Replace("'", "\\'"), "{", "}");
            }
            textWriter.Write("]");
            textWriter.Flush();
        }
    }
}
