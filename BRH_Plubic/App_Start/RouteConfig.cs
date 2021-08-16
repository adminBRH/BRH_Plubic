using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace BRH_Plubic
{
    public static class RouteConfig
    {

        // Edit
        public class MyWebFormsFriendlyUrlResolver : Microsoft.AspNet.FriendlyUrls.Resolvers.WebFormsFriendlyUrlResolver
        {
            protected override bool TrySetMobileMasterPage(HttpContextBase httpContext, System.Web.UI.Page page, String mobileSuffix)
            {
                if (mobileSuffix == "Mobile")
                {
                    return false;
                }
                else
                {
                    return base.TrySetMobileMasterPage(httpContext, page, mobileSuffix);
                }
            }
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings, new MyWebFormsFriendlyUrlResolver());
        }

        // Old
        //public static void RegisterRoutes(RouteCollection routes)
        //{
        //    var settings = new FriendlyUrlSettings();
        //    settings.AutoRedirectMode = RedirectMode.Permanent;
        //    routes.EnableFriendlyUrls(settings);
        //}
    }
}
