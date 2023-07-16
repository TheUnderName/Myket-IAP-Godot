<br/>
<p align="center">
  <a href="https://github.com/TheUnderName/Myket-IAP-Godot">
    <img src="https://myket.ir/core/images/logo/icon-700.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">پرداخت درون برنامه ای مایکت</h3>

  <p align="center">
    سازگار با ورژن 4.1 گودوت
    <br/>
    <br/>
    <a href="https://github.com/TheUnderName/Myket-IAP-Godot"><strong>نمایش کتابخانه »</strong></a>
    <br/>
    <br/>
    <a href="https://github.com/TheUnderName/Myket-IAP-Godot">مشاهده دمو</a>
    .
    <a href="https://github.com/TheUnderName/Myket-IAP-Godot/issues">گزارش مشکل</a>
    .
    <a href="https://github.com/TheUnderName/Myket-IAP-Godot/issues">درخواست ویژگی</a>
  </p>
</p>

![Downloads](https://img.shields.io/github/downloads/TheUnderName/Myket-IAP-Godot/total) ![Contributors](https://img.shields.io/github/contributors/TheUnderName/Myket-IAP-Godot?color=dark-green) ![Issues](https://img.shields.io/github/issues/TheUnderName/Myket-IAP-Godot) ![License](https://img.shields.io/github/license/TheUnderName/Myket-IAP-Godot) 


# نحوه راه اندازی
برای راه‌اندازی پلاگین پرداخت درون برنامه مایکت، شما باید قطعه کدهای زیر را به فایل AndroidManifest.xml خود اضافه کنید:

`<uses-permission android:name="ir.mservices.market.BILLING" />`


در صورتی که targetSdkVersion پروژه شما بیشتر از 29 باشد، فیلترینگ قابلیت مشاهده بسته‌ها (package visibility filtering) بر روی آن اعمال می‌شود. این به این معناست که اگر پروژه شما توسط مایکت نصب نباشد، دیگر قادر به برقراری ارتباط با مایکت نمی‌باشد.

برای حل این مشکل، می‌توانید قطعه کد زیر را داخل برچسب <manifest> در فایل AndroidManifest.xml کپی کنید:

`<queries>
    <package android:name="ir.mservices.market" />
    <intent>
        <action android:name="ir.mservices.market.InAppBillingService.BIND" />
        <data android:mimeType="*/*" />
    </intent>
</queries>`


