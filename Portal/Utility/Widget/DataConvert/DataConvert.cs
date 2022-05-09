using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;
using Utility.Widget.eraLogger;

namespace Utility.Widget.eraDataConvert
{
    public class DataConvert : IDisposable
    {
        #region Variables

        private static volatile DataConvert _Instance;

        #endregion

        #region Properties

        public static DataConvert Instance
        {
            get
            {
                if (_Instance == null)
                    _Instance = new DataConvert();

                return _Instance;
            }
        }

        #endregion

        #region Methods

        public object ParseConvert(object Input, Type FieldType)
        {
            try
            {
                switch (FieldType.Name)
                {
                    case "Int16":
                        return short.Parse(Input.ToString());
                    case "Int32":
                        return int.Parse(Input.ToString());
                    case "Int64":
                        return long.Parse(Input.ToString());
                    case "String":
                        return Input.ToString();
                    case "DateTime":
                        return DateTime.Parse(Input.ToString());
                    case "TimeSpan":
                        return TimeSpan.Parse(Input.ToString());
                    case "TypeDB":
                        return Enum.Parse(FieldType, Input.ToString());
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DataConvert.E.001", ex);
            }

            return null;
        }

        public T CastConvert<T>(object Input)
        {
            Type InputType = Input.GetType();

            try
            {
                if (InputType != typeof(DBNull))
                {
                    if (typeof(T).Equals(InputType))
                        return (T)Input;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DataConvert.E.002", ex);
            }

            return default(T);
        }

        public Image ByteArrayToImage(byte[] ByteArrayIn)
        {
            try
            {
                MemoryStream ImageStream = new MemoryStream(ByteArrayIn);
                return Image.FromStream(ImageStream);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DataConvert.E.003", ex);
            }

            return null;
        }

        public void Dispose()
        {
            if (_Instance != null)
                _Instance.Dispose();

            GC.Collect();
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}
