using System;

namespace Utility.Widget.eraHelper
{
    public delegate void Function();

    public class Helper
    {
        #region Properties

        public static DateTime Epoch
        {
            get { return new DateTime(1970, 1, 1); }
        }

        public static string GuidString
        {
            get { return Guid.NewGuid().ToString(); }
        }

        #endregion
    }
}