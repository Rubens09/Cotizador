using DPFP;
using DPFP.Capture;
using DPFP.Processing;
using System;
using System.Drawing;
using Utility.Widget.eraLogger;

namespace Utility.Widget.eraFingerprint
{
    public class Fingerprint : DPFP.Capture.EventHandler
    {
        public enum TypeCapture
        {
            CreateTemplate = 0,
            VerificationTemplate
        }

        public enum TypeDeviceStatus
        {
            OnReaderDisconnect = 0,
            OnReaderConnect
        }

        public enum TypeReaderStatus
        {
            OnFingerGone = 0,
            OnFingerTouch
        }

        #region Delegates

        public delegate void FingerprintCapturedHandler(TypeCapture TypeCap, bool Status, Image SampleImage, object FeatureTemplate, CaptureFeedback SampleQuality);
        public delegate void DeviceStatusHandler(TypeDeviceStatus DeviceStatus);
        public delegate void ReaderStatusHandler(TypeReaderStatus ReaderStatus);
        public delegate void ProcessStatusHandler(int ProcessStatus);

        #endregion

        #region Events

        public event FingerprintCapturedHandler FingerprintCapturedEvent;
        public event DeviceStatusHandler DeviceStatusEvent;
        public event ReaderStatusHandler ReaderStatusEvent;
        public event ProcessStatusHandler ProcessStatusEvent;

        #endregion

        #region Variables

        private TypeCapture _TypeCap;
        private Capture Capturer;
        private Enrollment Enroller;
        private TypeDeviceStatus _DeviceStatus = TypeDeviceStatus.OnReaderDisconnect;
        private TypeReaderStatus _ReaderStatus = TypeReaderStatus.OnFingerGone;
        private CaptureFeedback _SampleQuality = CaptureFeedback.None;
        private string _DeviceSerialNumber = string.Empty;
        private uint _SamplesRemaining = 0;

        #endregion

        #region Properties

        public TypeDeviceStatus DeviceStatus
        {
            get { return _DeviceStatus; }
        }

        public TypeReaderStatus ReaderStatus
        {
            get { return _ReaderStatus; }
        }

        public string DeviceSerialNumber
        {
            get { return _DeviceSerialNumber; }
        }

        public CaptureFeedback SampleQuality
        {
            get { return _SampleQuality; }
        }

        public uint SamplesRemaining
        {
            get { return _SamplesRemaining; }
        }

        #endregion

        #region Methods

        public void StartCapture(TypeCapture TypeCap)
        {
            try
            {
                if (Capturer == null)
                {
                    _TypeCap = TypeCap;
                    Capturer = new Capture();
                    Capturer.EventHandler = this;
                    Capturer.StartCapture();

                    if (TypeCap == TypeCapture.CreateTemplate)
                        Enroller = new Enrollment();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.001", ex);
            }
        }

        public void StopCapture()
        {
            if (null != Capturer)
            {
                try
                {
                    Capturer.StopCapture();
                    Capturer = null;
                }
                catch (Exception ex)
                {
                    Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.002", ex);
                }
            }
        }

        protected FeatureSet ExtractFeatures(Sample Sample, DataPurpose Purpose)
        {
            try
            {
                CaptureFeedback Responce = CaptureFeedback.None;
                FeatureExtraction Extractor = new FeatureExtraction();
                FeatureSet Features = new FeatureSet();
                Extractor.CreateFeatureSet(Sample, Purpose, ref Responce, ref Features);

                if (Responce == CaptureFeedback.Good)
                    return Features;
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.003", ex);
            }

            return null;
        }

        public Image ConvertSampleToImage(Sample Sample)
        {
            try
            {
                Bitmap BitmapImag = null;
                SampleConversion Convertor = new SampleConversion();
                Convertor.ConvertToPicture(Sample, ref BitmapImag);
                return (Image)BitmapImag;
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.004", ex);
            }

            return null;
        }

        #endregion

        #region EventHandler Members

        public void OnComplete(object Capture, string ReaderSerialNumber, Sample Sample)
        {
            try
            {
                _DeviceSerialNumber = ReaderSerialNumber;

                if (_TypeCap == TypeCapture.CreateTemplate)
                {
                    FeatureSet Features = ExtractFeatures(Sample, DataPurpose.Enrollment);

                    if (Features != null)
                    {
                        Enroller.AddFeatures(Features);

                        bool IsReady = false;
                        Template FetureTemplate = null;
                        _SamplesRemaining = Enroller.FeaturesNeeded;

                        switch (Enroller.TemplateStatus)
                        {
                            case Enrollment.Status.Ready:
                                FetureTemplate = Enroller.Template;
                                IsReady = true;
                                StopCapture();
                                break;

                            case Enrollment.Status.Failed:
                                IsReady = false;
                                Enroller.Clear();
                                StopCapture();
                                Exception Exp = new Exception("Fallo al momento de crear el template.");
                                Logger.WriteLog(TypeLog.WARN, "Fingerprint.W.001", Exp);
                                break;
                        }

                        if (FingerprintCapturedEvent != null)
                            FingerprintCapturedEvent(TypeCapture.CreateTemplate, IsReady, ConvertSampleToImage(Sample), FetureTemplate, _SampleQuality);
                    }
                }
                else
                {
                    FeatureSet Features = ExtractFeatures(Sample, DataPurpose.Verification);

                    if (Features != null)
                    {
                        if (FingerprintCapturedEvent != null)
                            FingerprintCapturedEvent(TypeCapture.VerificationTemplate, true, ConvertSampleToImage(Sample), Features, _SampleQuality);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.005", ex);
            }
        }

        public void OnFingerGone(object Capture, string ReaderSerialNumber)
        {
            try
            {
                _DeviceSerialNumber = ReaderSerialNumber;
                _ReaderStatus = TypeReaderStatus.OnFingerGone;

                if (ReaderStatusEvent != null)
                    ReaderStatusEvent(_ReaderStatus);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.006", ex);
            }
        }

        public void OnFingerTouch(object Capture, string ReaderSerialNumber)
        {
            try
            {
                _DeviceSerialNumber = ReaderSerialNumber;
                _ReaderStatus = TypeReaderStatus.OnFingerTouch;

                if (ReaderStatusEvent != null)
                    ReaderStatusEvent(_ReaderStatus);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.007", ex);
            }
        }

        public void OnReaderConnect(object Capture, string ReaderSerialNumber)
        {
            try
            {
                _DeviceSerialNumber = ReaderSerialNumber;
                _DeviceStatus = TypeDeviceStatus.OnReaderConnect;

                if (DeviceStatusEvent != null)
                    DeviceStatusEvent(_DeviceStatus);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.008", ex);
            }
        }

        public void OnReaderDisconnect(object Capture, string ReaderSerialNumber)
        {
            try
            {
                _DeviceSerialNumber = ReaderSerialNumber;
                _DeviceStatus = TypeDeviceStatus.OnReaderDisconnect;

                if (DeviceStatusEvent != null)
                    DeviceStatusEvent(_DeviceStatus);
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Fingerprint.E.009", ex);
            }
        }

        public void OnSampleQuality(object Capture, string ReaderSerialNumber, CaptureFeedback CaptureFeedback)
        {
            _DeviceSerialNumber = ReaderSerialNumber;
            _SampleQuality = CaptureFeedback;
        }

        #endregion
    }
}
