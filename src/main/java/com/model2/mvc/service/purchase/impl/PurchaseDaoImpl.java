package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public int addPurchase(Purchase purchase) throws Exception {
		return sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}


	public Purchase getPurchase(int prodNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", prodNo);
	}

	public List<Purchase> getPurchaseList(Map<String,Object> map) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getPurchaseList",map);
	}


	public int updatePurchase(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception {
		System.out.println("aa"+purchase.toString());
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}
	
	public int getTotalCount(Search search) {
	
		return 0;
	}

}
