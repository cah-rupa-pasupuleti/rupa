-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   
   URL = "https://tpl-order-dev.apps.cf.np.gc.cahcloud.net/order/cart/save"
   local data = [[
   {
    "orgCde": "AC",
    "customerNum": 832,
    "productDetails": [
        {
            "prodNum": 298842,
            "reqQty": "2",
            "unitPriceAmt": 1886.21,
            "shipUomDesc": "CASE",
            "pageFlg": true,
            "breakCde": "AMB"
        }
    ],
    "whseId": "CORD100",
    "orderNum": null
}]]
   
  data2 = [[
   {
    "orgCde": "AC",
    "customerNum": 832,
    "productDetails": [
        {
            "prodNum": 298842,
            "reqQty": "1",
            "unitPriceAmt": 1886.21,
            "shipUomDesc": "CASE",
            "pageFlg": true,
            "breakCde": "AMB",
            "orderDetailNum": 1125,
            "prodNam": "QUTENZA",
            "ndcID": "10144092901",
            "desc": "QUTENZA (CAPSAICIN) 2 8% PATCH 179G",
            "skuNum": "1014492901"
        }
    ],
    "whseId": "CORD100",
    "orderNum": 424
}]]
   local data3=[[
   {
    "customer": "AC1000",
    "customerPo": "4y54y56",
    "division": "01",
    "eliteOrderLineVO": [
        {
            "openOrderQuantity": "3",
            "requestItem": "1014492901",
            "sellingUom": "CASE",
            "shipVia": "F19"
        }
    ],
    "instruction": "",
    "orderType": "EDI",
    "organization": "AC",
    "paymentMethod": "1",
    "shipTo": "AC1003",
    "shipVia": "F19",
    "term": "99",
    "warehouse": "CORD100",
    "orderNum": 424,
    "totalCostAmt": 4036.49,
    "taxRate": 7,
    "customerAddress1": "AMERISOURCEBERGEN BERGEN",
    "customerAddress2": "ATTN ACCOUNTS PAYABLE PO BOX 247 ",
    "customerAddress3": "THOROFARE, NJ, 08086",
    "customerNum": 832,
    "shipAddress1": "AMERISOURCEBERGEN DRUG CORP BIRMINGHAM",
    "shipAddress2": "172 CAHABA VALLEY PKWY  ",
    "shipAddress3": "PELHAM, AL, 35124",
    "shippingAndHandlingCharges": 0,
    "shipViaLock": 0
}
   ]]
 
local c=net.http.post{body=data,url=URL,live=true,headers= {['Content-Type']='application/json'} }
	local y = net.http.respond{body=c}
 --[[local x =json.parse{data=c} 
  local F=io.open('C:\\source\\processed\\t1.json','w+')
   F:write(c)
   F:close()
local F=io.open('C:\\source\\processed\\t1.json','r')
 local d = F:read('*a')
 F:close(--]]
 
  local x =json.parse{data=c} 

     
   local f =json.parse{data=data2}
    local f1 =json.parse{data=data3}
   a = string.gsub( data2,f.orderNum, x.orderNum)
   b= string.gsub( a,f.productDetails[1].orderDetailNum, x.productDetails[1].orderDetailNum)
   c = string.gsub( data3,f1.orderNum, x.orderNum)
   print(a)
  

   
   

  

 local Y=net.http.post{body=b,url=URL,live=true,headers= {['Content-Type']='application/json'}}
   print(Y)
  net.http.respond{body=Y}
   
   URL1='https://tpl-order-dev.apps.cf.np.gc.cahcloud.net/order/save/elite'
  local Z=net.http.post{body=c,url=URL1,live=true,headers= {['Content-Type']='application/json'}}
   print(Z)
  
  
end