package com.model2.mvc.web.purchase;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public PurchaseController() {
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping(value = "addPurchase",method = RequestMethod.GET)
	public String addPurchaseView(@RequestParam("prodNo")String prodNo,Model model) throws Exception{
		System.out.println("/addPurchaseView.do");
		Product product=productService.getProduct(Integer.parseInt(prodNo));
		
		model.addAttribute("product", product);
		
		
		return "/purchase/addPurchaseView.jsp";
	}
	@RequestMapping(value ="addPurchase",method=RequestMethod.POST)
	public String addPurchase(@RequestParam("prodNo") int prodNo,@ModelAttribute("purchase") Purchase purchase,
				@ModelAttribute("product")Product product,HttpSession session ,Model model) throws Exception{

			
			product =productService.getProduct(prodNo);
			
			User user = (User) session.getAttribute("user");
			purchase.setBuyer(user);
			purchase.setPurchaseProd(product);
			purchaseService.addPurchase(purchase);
			
			

			model.addAttribute("purchase", purchase);
			
			return "forward:/purchase/addPurchaseResult.jsp";
		}
	
	@RequestMapping(value="getPurchase",method=RequestMethod.GET)
	public String getPurchase(@RequestParam("prodNo") int prodNo,Model model) 
			throws Exception {
		
		Purchase purchase=purchaseService.getPurchase(prodNo);
		System.out.println(purchase.getDlvyDate().getClass());
		model.addAttribute("purchase", purchase);

		return "forward:/purchase/getPurchase.jsp";
	}

	@RequestMapping(value="listPurchase",method=RequestMethod.GET)
	public String getPurchaseList(@ModelAttribute("search") Search search,Model model,HttpSession session)
			throws Exception{
			
			System.out.println("/listPurchase.do");
			
			User user = (User) session.getAttribute("user");
			
			if(search.getCurrentPage()==0) {
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			
			
			Map<String,Object>purchaseMap = new HashMap<String,Object>();
			System.out.println("search : "+search.toString());
			System.out.println("userId : "+user.getUserId());
		 	purchaseMap.put("search", search);
		 	purchaseMap.put("userId",user.getUserId());
			Map<String,Object> map = purchaseService.getPurchaseList(purchaseMap);
		 	
		 	List<Object> list = (List<Object>)map.get("list");
		 	
		 	Integer totalCount = (Integer)map.get("totalCount");
			
			Page resultPage	= 
			new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			
			return "forward:/purchase/listPurchase.jsp";
		}

	@RequestMapping(value="updatePurchase",method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase,@ModelAttribute("product") Product product,HttpSession session,HttpServletRequest request,@RequestParam("prodNo") int prodNo) throws Exception {
		System.out.println("/updatePurchase.do");
	
		
		purchase.setPurchaseProd(product);
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?prodNo="+product.getProdNo();
	}

	@RequestMapping(value="updatePurchase",method=RequestMethod.GET)
	public String updatePurchaseView(@ModelAttribute("purchase") Purchase purchase,@RequestParam("prodNo") String prodNo,Model model) throws Exception {
		
		purchase=purchaseService.getPurchase(Integer.parseInt(prodNo));
		model.addAttribute("purchase", purchase);
		
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCode",method=RequestMethod.GET)
	public String execute(@ModelAttribute("purchase") Purchase purchase,@RequestParam("prodNo") String prodNo,@RequestParam("tranCode") String tranCode,HttpSession httpSession) throws Exception {
		
		
		purchase = purchaseService.getPurchase(Integer.parseInt(prodNo));
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		User user = (User) httpSession.getAttribute("user");
		System.out.println("user roe : "+user.getRole());
		if (user.getRole().equals("admin")) {
			System.out.println("¿Ã«¡");
			return "redirect:/product/listProduct?menu=manage";
		}
		else {
			System.out.println("ø§Ω∫");
			return "redirect:/product/listProduct?menu=search";
		}
		
	}
	
	
}