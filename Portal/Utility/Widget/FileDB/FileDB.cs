using System;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Threading;
using System.Xml.Serialization;
using Utility.Widget.eraLogger;

namespace Utility.Widget.eraFileDB
{
    public class FileDB : IDisposable
    {
        public enum TypeQR
        {
            Insert = 1,
            Update,
            Delete
        }

        #region Variables

        private static volatile FileDB _Instance;

        #endregion

        #region Properties

        public static FileDB Instance
        {
            get
            {
                if (_Instance == null)
                    _Instance = new FileDB();

                return _Instance;
            }
        }

        #endregion

        #region Methods

        public bool Write<T>(string FilePath, T DataObject, int Timeout, string Note)
        {
            try
            {
                int Count = 0;

                while (true)
                {
                    try
                    {
                        if (!Directory.Exists(Path.GetDirectoryName(FilePath)))
                            Directory.CreateDirectory(Path.GetDirectoryName(FilePath));

                        using (FileStream FileStreamObject = new FileStream(FilePath, FileMode.Create))
                        {
                            using (FileStream OutputStream = File.Create(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), 1024, FileOptions.DeleteOnClose))
                            {
                                File.SetAttributes(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), FileAttributes.Temporary);
                                File.SetAttributes(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), FileAttributes.Hidden);

                                XmlSerializer XmlSerialilzerCompress = new XmlSerializer(typeof(T));
                                XmlSerialilzerCompress.Serialize(OutputStream, DataObject);

                                byte[] NoteByteArray = Encoding.UTF8.GetBytes(Note);
                                byte[] IntBytes = BitConverter.GetBytes(NoteByteArray.Length);

                                FileStreamObject.Write(IntBytes, 0, IntBytes.Length);
                                FileStreamObject.Write(NoteByteArray, 0, NoteByteArray.Length);

                                using (GZipStream ZipStream = new GZipStream(FileStreamObject, CompressionMode.Compress, true))
                                {
                                    OutputStream.Position = 0;
                                    OutputStream.CopyTo(ZipStream);
                                }
                            }
                        }

                        return true;
                    }
                    catch (IOException)
                    {
                    }

                    Thread.Sleep(1);

                    if (Count++ == Timeout)
                        break;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "FileDB.E.001", ex);
            }

            return false;
        }

        public T Read<T>(string FilePath, int Timeout, ref string Note)
        {
            T Result = default(T);

            try
            {
                int Count = 0;

                while (true)
                {
                    try
                    {
                        if (File.Exists(FilePath))
                        {
                            using (FileStream FileStreamObject = new FileStream(FilePath, FileMode.Open))
                            {
                                if (FileStreamObject.Length > 0)
                                {
                                    using (FileStream OutputStream = File.Create(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), 1024, FileOptions.DeleteOnClose))
                                    {
                                        File.SetAttributes(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), FileAttributes.Temporary);
                                        File.SetAttributes(Path.Combine(Path.GetDirectoryName(FilePath), "~" + Path.GetFileName(FilePath)), FileAttributes.Hidden);

                                        FileStreamObject.Position = 0;

                                        byte[] IntBytes = new byte[sizeof(int)];
                                        FileStreamObject.Read(IntBytes, 0, IntBytes.Length);
                                        byte[] NoteByteArray = new byte[BitConverter.ToInt32(IntBytes, 0)];
                                        FileStreamObject.Read(NoteByteArray, 0, NoteByteArray.Length);
                                        Note = Encoding.UTF8.GetString(NoteByteArray);

                                        using (GZipStream ZipStream = new GZipStream(FileStreamObject, CompressionMode.Decompress))
                                        {
                                            ZipStream.CopyTo(OutputStream);
                                            OutputStream.Position = 0;
                                        }

                                        XmlSerializer XmlSerialilzerCompress = new XmlSerializer(typeof(T));
                                        Result = (T)XmlSerialilzerCompress.Deserialize(OutputStream);
                                    }

                                    break;
                                }
                            }
                        }
                    }
                    catch (IOException)
                    {
                    }

                    Thread.Sleep(1);

                    if (Count++ == Timeout)
                        break;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "FileDB.E.002", ex);
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
