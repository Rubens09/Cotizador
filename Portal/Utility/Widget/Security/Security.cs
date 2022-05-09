using System;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using Utility.Widget;
using Utility.Widget.eraLogger;

namespace Utility.Widget.eraSecurity
{
    public class Security : IDisposable
    {
        #region Variables

        private static volatile Security _Instance;

        #endregion

        #region Properties

        public static Security Instance
        {
            get
            {
                if (_Instance == null)
                    _Instance = new Security();

                return _Instance;
            }
        }

        #endregion

        #region Methods

        public byte[] EncryptData(byte[] InputData)
        {
            byte[] result = null;

            try
            {
                byte[] key = Encoding.UTF8.GetBytes(WidgetConfig.Key);
                byte[] iv = Encoding.UTF8.GetBytes(WidgetConfig.Iv);

                using (MemoryStream outputStream = new MemoryStream())
                {
                    RijndaelManaged RMCrypto = new RijndaelManaged();

                    using (CryptoStream cryptoStream = new CryptoStream(outputStream, RMCrypto.CreateEncryptor(key, iv), CryptoStreamMode.Write))
                    {
                        cryptoStream.Write(InputData, 0, InputData.Length);
                    }

                    result = outputStream.ToArray();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Security.E.001", ex);
            }

            return result;
        }

        public byte[] DecryptData(byte[] InputData)
        {
            byte[] result = null;

            try
            {
                byte[] key = Encoding.UTF8.GetBytes(WidgetConfig.Key);
                byte[] iv = Encoding.UTF8.GetBytes(WidgetConfig.Iv);

                using (MemoryStream inputStream = new MemoryStream(InputData))
                {
                    RijndaelManaged RMCrypto = new RijndaelManaged();

                    using (CryptoStream cryptoStream = new CryptoStream(inputStream, RMCrypto.CreateDecryptor(key, iv), CryptoStreamMode.Read))
                    {
                        using (MemoryStream outputStream = new MemoryStream())
                        {
                            cryptoStream.CopyTo(outputStream);
                            result = outputStream.ToArray();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Security.E.002", ex);
            }

            return result;
        }

        public string EncryptString(string InputData)
        {
            StringBuilder StringInput = null;

            try
            {
                int I = 0;
                byte[] ByteArrayInput = new byte[InputData.Length];
                foreach (char Item in InputData.ToCharArray())
                    ByteArrayInput[I++] = (byte)Item;
                ByteArrayInput = EncryptData(ByteArrayInput);
                StringInput = new StringBuilder(ByteArrayInput.Length);
                foreach (byte Item in ByteArrayInput)
                    StringInput.Append((char)Item);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Security.E.003", ex);
            }

            return StringInput != null ? StringInput.ToString() : null;
        }

        public string DecryptString(string InputData)
        {
            StringBuilder StringInput = null;

            try
            {
                int I = 0;
                byte[] ByteArrayInput = new byte[InputData.Length];
                foreach (char Item in InputData.ToCharArray())
                    ByteArrayInput[I++] = (byte)Item;
                ByteArrayInput = DecryptData(ByteArrayInput);
                StringInput = new StringBuilder(ByteArrayInput.Length);
                foreach (byte Item in ByteArrayInput)
                    StringInput.Append((char)Item);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Security.E.004", ex);
            }

            return StringInput != null ? StringInput.ToString() : null;
        }

        public Stream EncryptStream(Stream InputData)
        {
            MemoryStream outStream = null;

            using (MemoryStream inStream = (MemoryStream)InputData)
            {
                outStream = new MemoryStream(EncryptData(inStream.ToArray()));
            }

            return (Stream)outStream;
        }

        public Stream DecryptStream(Stream InputData)
        {
            MemoryStream outStream = null;

            using (MemoryStream inStream = (MemoryStream)InputData)
            {
                outStream = new MemoryStream(DecryptData(inStream.ToArray()));
            }

            return (Stream)outStream;
        }

        public string EncryptMD5(string InputData)
        {
            string Result = null;

            try
            {
                using (MD5 Md5Hash = MD5.Create())
                {
                    byte[] Data = Md5Hash.ComputeHash(Encoding.UTF8.GetBytes(InputData));
                    StringBuilder SBuilder = new StringBuilder();
                    for (int i = 0; i < Data.Length; i++)
                        SBuilder.Append(Data[i].ToString("x2"));
                    Result = SBuilder.ToString();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Security.E.005", ex);
            }

            return Result;
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