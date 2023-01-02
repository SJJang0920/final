package com.project.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.customer.CustomerDTO;
import com.project.manager.ManagerDTO;

@Controller
public class LoginController {
	LoginServise loginService;
	
	@Autowired
	public LoginController(LoginServise loginService) {
		super();
		this.loginService = loginService;
	}
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(String id, String pass, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		ManagerDTO manager = new ManagerDTO();
		manager.setManager_id(id);
		manager.setManager_pass(pass);
		ManagerDTO managerUser = loginService.managerlogin(manager);
		
	
		CustomerDTO customer = new CustomerDTO(); 
		customer.setCustomer_id(id); 
		customer.setPass(pass);
		CustomerDTO customerUser = loginService.customerlogin(customer);
		 
		
		String viewName = "";
		if (managerUser != null && !managerUser.getState().equals("퇴사")) {
			HttpSession session = request.getSession();
			session.setAttribute("user", managerUser);
			viewName = "index";
		} else if (customerUser != null && customerUser.getState().equals("정상")){
			HttpSession session = request.getSession();
			session.setAttribute("user", customerUser);
			viewName = "index";
		}else {
			viewName = "login";
		}
		mav.setViewName(viewName);
		return mav;
	}
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		if(session!=null) {
			session.invalidate();
		}
		return "redirect:/index";
	}
	
	public String findId(String name, String phone_no) {
		return "";
	}

	public String findPassword(CustomerDTO dto) {
		return "";
	}
	
	
	
	
}
