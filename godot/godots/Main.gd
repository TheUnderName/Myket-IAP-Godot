extends Node2D
@onready var resPopup: Popup = $Control/ResPop
@onready var resLbl: Label = $Control/ResPop/ResPanel/ResVB/ResLbl

var myketBilling: JNISingleton = null
const SKU_PREMIUM = "myket_premium"

func _ready() -> void:
	if Engine.has_singleton("MyketInAppBilling"):
		myketBilling = Engine.get_singleton("MyketInAppBilling")
		myketBilling.setApplicationKey("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCQt6havSvU4wvQJGj2K2xyZ7Y8q3Qmk0lEGwSrBBhOOQe2jWFMl2psg4foP6jPC7VB4klujCouBSJXVBrkYvMX5ruk5mF2tgieaf4rxtoD9HQxKZG+3474qeP/t8hryGva5fmv1WXg/TBdHBWd1n+G2pOuf3/yiYz2IIKu3deIbwIDAQAB")
		myketBilling.connect("connected", Callable(self, "_on_MyketConnected"))
		myketBilling.connect("query_sku_details_finished", Callable(self,"_on_MyketQuerySkuFinished"))
		myketBilling.connect("purchase_finished", Callable(self,"_on_MyketPurchaseFinished"))
	else:
		print("No MyketInAppBilling plugin.")
	
	return
	




func _on_Button_pressed() -> void:
	if myketBilling == null:
		resLbl.text = "InAppBilling plugin is not available for this device."
		resPopup.show()
		return
	
	myketBilling.startConnection()
	
	return
	


func _on_MyketConnected(successful: bool, resMsg: String) -> void:
	print("Connected: ", str(successful))
	
	if successful:
		myketBilling.querySkuDetails()
	else:

		resLbl.text = resMsg
		resPopup.show()
		pass
	
	return
	


func _on_MyketQuerySkuFinished(results: Array) -> void:
	for res in results:
		print(res)
	
	if not results.has(SKU_PREMIUM):
		print(myketBilling.purchase(SKU_PREMIUM))
	else:
		_setGamePremium()
		pass
	
	return
	


func _on_MyketPurchaseFinished(result: Dictionary) -> void:
	print("Purchase Finished: ", result)
	
	return
	


func _setGamePremium() -> void:

	print("Game is premium now.")
	return
	
