#load "csomHelper.csx"
 
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.Client.Utilities;

using System.Net;


public static async Task<HttpResponseMessage> Run(HttpRequestMessage req, TraceWriter log)
{
    string siteUrl = "https://exedev.sharepoint.com/sites/KASF";
    string path = "/sites/KASF/Faktury/Dokument.docx";

    // Get Office Online (WOPI) URL
    using (var ctx = await csomHelper.GetClientContext(siteUrl))
    {
        ClientResult<string> result;
        
        Microsoft.SharePoint.Client.File f = ctx.Web.GetFileByServerRelativeUrl (path);
        result = f.ListItemAllFields.GetWOPIFrameUrl(SPWOPIFrameAction.View);
        
        ctx.Load(f.ListItemAllFields);
        ctx.ExecuteQuery();
        
        Uri itemUri = new Uri(result.Value);

        return req.CreateResponse(HttpStatusCode.OK, itemUri);

    }

}
