
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
## نحوه راه اندازی
پلاگین را روی پروژه خود نصب کنید و برای راه اندازی ان از مثال فولدر GDProject استفاده کنید.

حتما تیک پلاگین را از اکسپورت فعال کنید.
## کد مثال 
``` gdscript
extends Node2D
@onready var resPopup: Popup = $Control/ResPop
@onready var resLbl: Label = $Control/ResPop/ResPanel/ResVB/ResLbl

var myketBilling: JNISingleton = null
const SKU_PREMIUM = "SDSDSA" # شناسه ی محصول

func _ready() -> void:
	if Engine.has_singleton("MyketInAppBilling"):
		myketBilling = Engine.get_singleton("MyketInAppBilling")
		myketBilling.setApplicationKey("") # کلید فعالسازی پرداخت درون برنامه ای که در پنل مایکت موجود می باشد
		myketBilling.connect("connected", Callable(self, "_on_MyketConnected"))
		myketBilling.connect("query_sku_details_finished", Callable(self,"_on_MyketQuerySkuFinished"))
		myketBilling.connect("purchase_finished", Callable(self,"_on_MyketPurchaseFinished"))
	else:
		print("No MyketInAppBilling plugin.")
	
	return
	




func _on_Button_pressed() -> void:
	if myketBilling == null:
		resLbl.text = "InAppBilling plugin is not available for this device." # در دسترس نبودن پلاگین
		resPopup.show()
		return
	
	myketBilling.startConnection()
	
	return
	


func _on_MyketConnected(successful: bool, resMsg: String) -> void:
	print("Connected: ", str(successful))
	
	if successful:
		myketBilling.querySkuDetails() # دریافت اطلاعات
	else:

		resLbl.text = resMsg
		resPopup.show()
		pass
	
	return
	


func _on_MyketQuerySkuFinished(results: Array) -> void: # بعداز دریافت اطلاعات
	for res in results:
		print(res)
	
	if not results.has(SKU_PREMIUM):
		print(myketBilling.purchase(SKU_PREMIUM))
	else:
		_setGamePremium()
		pass
	
	return
	


func _on_MyketPurchaseFinished(result: Dictionary) -> void: # پرداخت موفق
	print("Purchase Finished: ", result)
	
	return
	


func _setGamePremium() -> void: # پرمیوم کاربر

	print("Game is premium now.")
	return
```
