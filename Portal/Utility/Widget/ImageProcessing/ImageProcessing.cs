using System.Drawing;

namespace Utility
{
    public class ImageProcessing
    {
        #region Methods

        public static Bitmap CropImage(Bitmap ImageInput, Rectangle CropArea)
        {
            return ImageInput.Clone(CropArea, ImageInput.PixelFormat);
        }

        public static Bitmap RotateImage(Bitmap ImageInput, float Angle)
        {
            Bitmap ReturnBitmap = new Bitmap(ImageInput.Width, ImageInput.Height);
            Graphics GraphicsImage = Graphics.FromImage(ReturnBitmap);
            GraphicsImage.TranslateTransform((float)ImageInput.Width / 2, (float)ImageInput.Height / 2);
            GraphicsImage.RotateTransform(Angle);
            GraphicsImage.TranslateTransform(-(float)ImageInput.Width / 2, -(float)ImageInput.Height / 2);
            GraphicsImage.DrawImage(ImageInput, new Point(0, 0));
            return ReturnBitmap;
        }

        #endregion
    }
}
