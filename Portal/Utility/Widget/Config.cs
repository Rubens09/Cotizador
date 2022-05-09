namespace Utility.Widget
{
    public class WidgetConfig
    {
        #region Widget

        public const string Version = "1.0.0.0";

        #endregion

        #region Logger

        public const bool IsDebug = true;
        public const string EventLogName = "DataLog";
        public const string PathFileLog = @"C:\Log.log";

        #endregion

        #region Security

        public const string Key = @"~Y&1NGpKk1Y5RNJ0Ow7Z{4}61Q%d[a_*";
        public const string Iv = @"VKe1N/j%=2o3hIP*";

        #endregion

        #region FileConfig

        public const bool IsEncrypted = false;
        public const string PathFileConfig = @"C:\Config.cfg";
        public const string ClassConfigNamespace = "Utility.Config";

        #endregion
    }
}