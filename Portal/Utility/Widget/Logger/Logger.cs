using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using Utility.Widget;

namespace Utility.Widget.eraLogger
{
    public enum TypeLog
    {
        DEBUG = 1,
        ERROR,
        FATAL,
        INFO,
        WARN
    }

    public static class Logger
    {
        #region Methods

        public static void WriteLog(TypeLog TypeLog, string IdEvent, Exception Exception, [Optional] bool StackTrace)
        {
            string typeLogString = string.Empty;
            
            switch (TypeLog)
            {
                case TypeLog.DEBUG:
                    typeLogString = TypeLog.DEBUG.ToString();
                    break;
                case TypeLog.ERROR:
                    typeLogString = TypeLog.ERROR.ToString();
                    break;
                case TypeLog.FATAL:
                    typeLogString = TypeLog.FATAL.ToString();
                    break;
                case TypeLog.INFO:
                    typeLogString = TypeLog.INFO.ToString();
                    break;
                case TypeLog.WARN:
                    typeLogString = TypeLog.WARN.ToString();
                    break;
            }

            if (typeLogString != string.Empty)
            {
                string stringLog = "[" + DateTime.Now.ToString("s").Replace('T', ' ') + "] [" + typeLogString + "] [" + IdEvent + "] \"" + Exception.Message + "\"" + (StackTrace == true ? " \"" + Exception.StackTrace + "\"" : "");

                WriteFileLine(stringLog);
            }
        }

        private static void WriteFileLine(string StringLog)
        {
            if (WidgetConfig.IsDebug)
                throw new NotImplementedException(StringLog);

            string FullPath = Path.GetFullPath(WidgetConfig.PathFileLog);

            try
            {
                if (Directory.Exists(Path.GetDirectoryName(FullPath)))
                    Directory.CreateDirectory(Path.GetDirectoryName(FullPath));
            }
            catch
            {
            }

            using (TextWriterTraceListener ListenerLog = new TextWriterTraceListener(Path.GetFullPath(WidgetConfig.PathFileLog), WidgetConfig.EventLogName))
            {
                ListenerLog.WriteLine(StringLog.Replace("\r\n", " "));
                ListenerLog.Flush();
            }
        }

        #endregion
    }
}
