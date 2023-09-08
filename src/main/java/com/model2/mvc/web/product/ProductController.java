package com.model2.mvc.web.product;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping(value = "addProduct",method = RequestMethod.GET)
	public String addProductView() throws Exception{
		
		System.out.println("/addProductView");
		
		return "redirect:/product/addProductView.jsp";
	}
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,Model model )throws Exception {
           
        
		product.setManuDate(product.getManuDate().replace("-", ""));
        productService.addProduct(product);
            
        product = productService.getProduct(product.getProdNo());

	    model.addAttribute("product", product);
	    return "forward:/product/getProduct.jsp";
		
	}
	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct",method= RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		final String ATTACHES_DIR = request.getSession().getServletContext().getRealPath("/images/uploadFiles");
		
		System.out.println("/getProduct");
		
		Product product = productService.getProduct(prodNo);
		
		// 날짜가 이상하게 나와서 강제변환해 model 태움
		
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = outputFormat.format(product.getRegDate());
		/*----------쿠키 추가 로직---------*/
		String value = null;
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
		    for (Cookie cookie : cookies) {
		        if (cookie.getName().equals("history")) {
		            value = URLDecoder.decode(cookie.getValue(), "UTF-8");
		            System.out.println(" if문 안에서 value : " +value);
		        }
		    }
		}
		if (value == null) {
		    value = "";
		}
		value += Integer.toString(prodNo)+"S";
		System.out.println("distinctValue :"+value);
		String distinctValue = "";
		String[] tmp = value.split("S");
		List<String> list = new ArrayList<>(Arrays.asList(tmp));
		if (list.contains(Integer.toString(prodNo))) {
			
		    while(list.remove(Integer.toString(prodNo))); 
		    list.add(Integer.toString(prodNo));
		     
		}
		for (String i : list) {
			distinctValue += i+"S";
		}
		
		Cookie cookie = new Cookie("history", distinctValue);
		response.addCookie(cookie);
		/*-----------------------------*/
		
		request.setAttribute("dir", ATTACHES_DIR);
		model.addAttribute("date", date);
		model.addAttribute("menu", request.getParameter("menu"));
		model.addAttribute("product",product);
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String listProduct(@ModelAttribute("search") Search search,@RequestParam("menu") String menu,Model model) throws Exception {
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		List<String> totalProductName = productService.getTotalProductName();
		
		System.out.println(totalProductName);
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
		System.out.println(resultPage);
		String replacedMenu = menu.replaceAll(",.*", "");
		model.addAttribute("menu",replacedMenu);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("totalProductName", totalProductName);
		model.addAttribute("resultPage",resultPage);
		model.addAttribute("search", search);
		
		System.out.println(model.getAttribute("menu"));
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	
	//@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct",method=RequestMethod.GET)
	public String updateProductView(@RequestParam("prodNo") int prodNo,Model model) throws Exception {
		
		System.out.println("/updateProductView");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product",product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct",method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, Model model) throws Exception {
		
		productService.updateProduct(product);
		
		System.out.println(product);
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=manage";
	}
	//@RequestMapping("/history.do")
	@RequestMapping(value="history",method=RequestMethod.GET)
	public String history(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		ArrayList<Product> list = new ArrayList<Product>();
		Map<String,Object> map = new HashMap<String,Object>();
		String history = null;
		Cookie[] cookies = request.getCookies();
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			if (history != null) {
				String[] h = history.split("S");
				for (int i = 0; i < h.length; i++) {
					if (!h[i].equals("null")) {
						
						Product product = productService.getProduct(Integer.parseInt(h[i]));
						list.add(product);
					
						map.put("list", list);
					}
				}
			}
		}
		model.addAttribute("list", map.get("list"));
//		request.setAttribute("list", map.get("list"));
		
		
		return "forward:/history.jsp";
	}
	
}
