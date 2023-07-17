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
	
