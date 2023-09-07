package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

public int addPurchase(Purchase purchase) throws Exception;
	
	public Purchase getPurchase(int no)  throws Exception;
	
	
	
	public int updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;

	public int getTotalCount(Search search);



	public List<Purchase> getPurchaseList(Map<String, Object> purchaseMap)throws Exception;
}