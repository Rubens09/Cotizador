using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using Utility;
using Utility.Widget.eraDataConvert;
using Utility.Widget.eraLogger;
using Utility.Widget.eraSecurity;

namespace Utility.Widget.eraFileConfig
{
    public class FileConfig
    {
        #region Variables

        public static dynamic Configuration;

        #endregion

        #region Config Methods

        public static bool ReadFile()
        {
            try
            {
                Type ConfigNamespaceType = Type.GetType(WidgetConfig.ClassConfigNamespace);

                if (ConfigNamespaceType != null)
                {
                    Configuration = Activator.CreateInstance(ConfigNamespaceType);

                    if (File.Exists(WidgetConfig.PathFileConfig))
                    {
                        string FileString = new StreamReader(WidgetConfig.PathFileConfig).ReadToEnd();

                        if (WidgetConfig.IsEncrypted)
                            FileString = Security.Instance.DecryptString(FileString);

                        FieldInfo[] FieldInfos = Configuration.GetType().GetFields();
                        List<string> ListConfig = new List<string>(FileString.Split(new string[] { "\r\n", "\n" }, StringSplitOptions.None));

                        foreach (FieldInfo Field in FieldInfos)
                        {
                            DataConvert Convert = new DataConvert();
                            Field.SetValue(Configuration, Convert.ParseConvert(ListConfig.Find(delegate(string Conf) { return Conf.Split(new string[] { "#:#" }, StringSplitOptions.None)[0] == Field.Name; }).Split(new string[] { "#:#" }, StringSplitOptions.None)[1], Field.FieldType));
                        }

                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    throw new Exception("No se encuentra la clase de configuración.");
                }
            }
            catch(Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "FileConfig.E.001", ex);
            }

            return false;
        }

        public static bool WriteFile()
        {
            try
            {
                Type ConfigNamespaceType = Type.GetType(WidgetConfig.ClassConfigNamespace);

                if (ConfigNamespaceType != null)
                {
                    Configuration = Activator.CreateInstance(ConfigNamespaceType);

                    if (File.Exists(WidgetConfig.PathFileConfig))
                        File.Delete(WidgetConfig.PathFileConfig);

                    using (StreamWriter streamWriter = new StreamWriter(WidgetConfig.PathFileConfig, true))
                    {
                        FieldInfo[] FieldInfos = Configuration.GetType().GetFields();
                        string StringConfig = string.Empty;

                        foreach (FieldInfo FieldInf in FieldInfos)
                            StringConfig += FieldInf.Name + "#:#" + FieldInf.GetValue(Configuration).ToString() + "\r\n";

                        StringConfig = StringConfig.Remove(StringConfig.Length - 2, 2);

                        if (WidgetConfig.IsEncrypted)
                            StringConfig = Security.Instance.EncryptString(StringConfig);

                        streamWriter.Write(StringConfig);
                    }

                    return true;
                }
                else
                {
                    throw new Exception("No se encuentra la clase de configuración.");
                }
            }
            catch(Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "FileConfig.E.002", ex);
            }

            return false;
        }

        #endregion
    }
}
